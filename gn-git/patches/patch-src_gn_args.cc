$NetBSD$

- Handle NetBSD/evbarm correctly.

--- src/gn/args.cc.orig
+++ src/gn/args.cc
@@ -389,6 +389,10 @@
     return kX86;
   if (os_arch == "x86_64")
     return kX64;
+  if (os_arch == "evbarm" && sizeof(long) == 8)
+    return kArm64;
+  if (os_arch == "evbarm" && sizeof(long) == 4)
+    return kArm;
   if (os_arch == "aarch64" || os_arch == "arm64")
     return kArm64;
   if (os_arch.substr(0, 3) == "arm")
