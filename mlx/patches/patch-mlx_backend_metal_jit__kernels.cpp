$NetBSD$

Fix the JIT (MLX_METAL_JIT) build of the head-dim split NAX attention
kernel: attention_nax_dsplit has no BV template parameter, so passing
it made the instantiation fail to compile ("reference to overloaded
function could not be resolved") for head dims 256 and 512.

--- mlx/backend/metal/jit_kernels.cpp.orig
+++ mlx/backend/metal/jit_kernels.cpp
@@ -1422,17 +1422,29 @@
         kernel_source,
         metal::utils(),
         metal::steel_attention_nax(),
-        get_template_definition(
-            lib_name,
-            split_d ? "attention_nax_dsplit" : "attention_nax",
-            get_type_string(q.dtype()),
-            bq,
-            bk,
-            bd,
-            bv,
-            wm,
-            wn,
-            get_type_string(m.dtype())));
+        // attention_nax_dsplit has no BV template parameter (BV == BD),
+        // unlike attention_nax; see steel_attention_nax.metal.
+        split_d ? get_template_definition(
+                      lib_name,
+                      "attention_nax_dsplit",
+                      get_type_string(q.dtype()),
+                      bq,
+                      bk,
+                      bd,
+                      wm,
+                      wn,
+                      get_type_string(m.dtype()))
+                : get_template_definition(
+                      lib_name,
+                      "attention_nax",
+                      get_type_string(q.dtype()),
+                      bq,
+                      bk,
+                      bd,
+                      bv,
+                      wm,
+                      wn,
+                      get_type_string(m.dtype())));
     return kernel_source;
   });
   return d.get_kernel(kernel_name, lib, hash_name, func_consts);
