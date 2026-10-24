$NetBSD$

Default to pkgsrc's libLLVM (lang/llvm) instead of Homebrew/Linux system
paths.  DRJIT_LIBLLVM_PATH still overrides it.

--- ext/drjit-core/src/llvm_api.cpp.orig	2026-10-24 00:34:53
+++ ext/drjit-core/src/llvm_api.cpp	2026-10-24 00:34:53
@@ -62,6 +62,9 @@
     if (!jitc_llvm_handle) {
 #if defined(_WIN32)
         const char *llvm_fname = "LLVM-C.dll", *llvm_glob = nullptr;
+#elif 1 /* pkgsrc */
+        const char *llvm_fname = "@LIBLLVM@",
+                   *llvm_glob  = "@LIBLLVM@";
 #elif defined(__linux__)
         const char *llvm_fname = "libLLVM.so",
                    *llvm_glob  = "/usr/lib/{x86_64-linux-gnu,aarch64-linux-gnu,wsl/lib}/libLLVM*.so.*";
