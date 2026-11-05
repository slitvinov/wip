$NetBSD$

MLX_METAL_RUNTIME_COMPILE: state for the on-demand kernel libraries.

--- mlx/backend/metal/device.h.orig
+++ mlx/backend/metal/device.h
@@ -236,6 +236,10 @@ class MLX_API Device {
       const MTLFCList& func_consts = {},
       const std::vector<MTL::Function*>& linked_functions = {});
 
+  // MLX_METAL_RUNTIME_COMPILE: the library holding base_name, compiled
+  // from embedded source on first use, as there is no mlx.metallib.
+  MTL::Library* get_runtime_library_(const std::string& base_name);
+
   NS::SharedPtr<MTL::Device> device_;
   ResidencySets residency_sets_;
 
@@ -243,6 +247,9 @@ class MLX_API Device {
   std::shared_mutex library_mtx_;
   std::unordered_map<std::string, NS::SharedPtr<MTL::Library>> library_map_;
   NS::SharedPtr<MTL::Library> default_library_;
+  std::mutex runtime_mtx_;
+  size_t runtime_libs_built_{0};
+  std::unordered_map<std::string, MTL::Library*> runtime_functions_;
   std::unordered_map<
       MTL::Library*,
       std::unordered_map<std::string, NS::SharedPtr<MTL::ComputePipelineState>>>
