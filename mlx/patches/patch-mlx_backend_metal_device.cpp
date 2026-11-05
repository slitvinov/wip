$NetBSD$

MLX_METAL_RUNTIME_COMPILE: without mlx.metallib, compile the embedded
kernel sources through the Metal API on first use, one library per
kernel file, until the requested function is found.

--- mlx/backend/metal/device.cpp.orig
+++ mlx/backend/metal/device.cpp
@@ -30,6 +30,12 @@ struct hash<NS::SharedPtr<T>> {
 
 namespace mlx::core::metal {
 
+#ifdef MLX_METAL_RUNTIME_COMPILE
+// Generated: (name, source) for each kernel file normally in mlx.metallib.
+const std::vector<std::pair<std::string, const char* (*)()>>&
+runtime_kernel_sources();
+#endif
+
 namespace {
 
 constexpr const char* default_mtllib_path = METAL_PATH;
@@ -611,7 +617,15 @@ MTL::ComputeCommandEncoder* CommandEncoder::get_command_encoder() {
 
 Device::Device() : device_(load_device()), residency_sets_(device_.get()) {
   auto pool = new_scoped_memory_pool();
+#ifdef MLX_METAL_RUNTIME_COMPILE
+  // There is no mlx.metallib unless set_metallib_path() names one;
+  // otherwise get_runtime_library_() compiles the kernels on demand.
+  if (!get_metallib_path().empty()) {
+    default_library_ = NS::TransferPtr(load_default_library(device_.get()));
+  }
+#else
   default_library_ = NS::TransferPtr(load_default_library(device_.get()));
+#endif
   arch_ = env::metal_gpu_arch();
   if (arch_.empty()) {
     arch_ = std::string(device_->architecture()->name()->utf8String());
@@ -920,6 +934,36 @@ MTL::ComputePipelineState* Device::get_kernel(
   return get_kernel_(base_name, mtl_lib, kname, func_consts, linked_functions);
 }
 
+MTL::Library* Device::get_runtime_library_(const std::string& base_name) {
+#ifdef MLX_METAL_RUNTIME_COMPILE
+  std::lock_guard lock(runtime_mtx_);
+  const auto& sources = runtime_kernel_sources();
+  // Compile the kernel files in turn until one defines base_name, so a
+  // process only pays for the files it uses.  Each compile takes 0.1-0.7 s
+  // the first time; the system Metal shader cache makes repeats cheap.
+  while (true) {
+    if (auto it = runtime_functions_.find(base_name);
+        it != runtime_functions_.end()) {
+      return it->second;
+    }
+    if (runtime_libs_built_ == sources.size()) {
+      throw std::runtime_error(
+          fmt::format("[metal::Device] Unknown kernel {}.", base_name));
+    }
+    auto& [name, source] = sources[runtime_libs_built_++];
+    auto lib = get_library("mlx_" + name, [&]() { return source(); });
+    auto pool = new_scoped_memory_pool();
+    auto names = lib->functionNames();
+    for (int i = 0, c = (int)names->count(); i < c; i++) {
+      auto fn = reinterpret_cast<NS::String*>(names->object(i));
+      runtime_functions_.emplace(fn->utf8String(), lib);
+    }
+  }
+#else
+  return default_library_.get();
+#endif
+}
+
 MTL::ComputePipelineState* Device::get_kernel(
     const std::string& base_name,
     const std::string& hash_name /*  = "" */,
@@ -927,7 +971,8 @@ MTL::ComputePipelineState* Device::get_kernel(
     const std::vector<MTL::Function*>& linked_functions /*  = {} */) {
   return get_kernel(
       base_name,
-      default_library_.get(),
+      default_library_ ? default_library_.get()
+                       : get_runtime_library_(base_name),
       hash_name,
       func_consts,
       linked_functions);
