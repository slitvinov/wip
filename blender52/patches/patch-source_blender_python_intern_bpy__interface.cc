$NetBSD$

Using the system Python is intended with pkgsrc on macOS, do not warn.

--- source/blender/python/intern/bpy_interface.cc.orig
+++ source/blender/python/intern/bpy_interface.cc
@@ -573,7 +573,7 @@
       }
       else {
 /* Common enough to use the system Python on Linux/Unix, warn on other systems. */
-#  if defined(__APPLE__) || defined(_WIN32)
+#  if defined(_WIN32)
         fprintf(stderr,
                 "Bundled Python not found and is expected on this platform "
                 "(the 'install' target may have not been built)\n");
