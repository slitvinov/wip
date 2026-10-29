$NetBSD$

When an absolute CMAKE_INSTALL_NAME_DIR is requested (pkgsrc does this
on Darwin), give the libraries of plugins an absolute install name too
instead of @loader_path, which pkg_add cannot resolve in REQUIRES.

--- CMake/ParaViewPlugin.cmake.orig
+++ CMake/ParaViewPlugin.cmake
@@ -1183,7 +1183,11 @@
     set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${_paraview_plugin_subdir}")
     set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${_paraview_plugin_subdir}")
     set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/${_paraview_plugin_subdir}")
-    set(CMAKE_INSTALL_NAME_DIR "@loader_path")
+    if (IS_ABSOLUTE "${_paraview_plugin_CMAKE_INSTALL_NAME_DIR}")
+      set(CMAKE_INSTALL_NAME_DIR "${CMAKE_INSTALL_PREFIX}/${_paraview_plugin_subdir}")
+    else ()
+      set(CMAKE_INSTALL_NAME_DIR "@loader_path")
+    endif ()
 
     vtk_module_build(
       MODULES             ${plugin_modules}
