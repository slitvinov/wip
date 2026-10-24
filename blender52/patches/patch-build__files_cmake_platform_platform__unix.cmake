$NetBSD$

Link the static shaderc library, like Blender's own builds; pkgsrc's
graphics/shaderc provides it as the shaderc_static pkg-config module.

--- build_files/cmake/platform/platform_unix.cmake.orig
+++ build_files/cmake/platform/platform_unix.cmake
@@ -158,7 +158,7 @@ if(WITH_VULKAN_BACKEND)
     # Use system libs
     find_package(PkgConfig)
     pkg_check_modules(VULKAN REQUIRED vulkan)
-    pkg_check_modules(SHADERC REQUIRED shaderc)
+    pkg_check_modules(SHADERC REQUIRED shaderc_static)
   endif()
 endif()
 add_bundled_libraries(vulkan/lib)
