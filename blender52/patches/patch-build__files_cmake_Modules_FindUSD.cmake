$NetBSD$

Support a non-monolithic OpenUSD build (as installed by wip/openusd):
link all of its libraries instead of only libusd_usd.

--- build_files/cmake/Modules/FindUSD.cmake.orig
+++ build_files/cmake/Modules/FindUSD.cmake
@@ -68,6 +68,11 @@
     get_filename_component(USD_LIBRARY_DIR ${USD_LIBRARY} DIRECTORY)
     set(USD_INCLUDE_DIRS ${USD_INCLUDE_DIR})
     set(USD_LIBRARIES ${USD_LIBRARY})
+    # A non-monolithic USD build: link all of its libraries.
+    if(NOT USD_LIBRARY MATCHES "usd_(usd_)?ms?[.]")
+      file(GLOB USD_LIBRARIES
+        "${USD_LIBRARY_DIR}/${CMAKE_SHARED_LIBRARY_PREFIX}${PXR_LIB_PREFIX}*${CMAKE_SHARED_LIBRARY_SUFFIX}")
+    endif()
     if(EXISTS ${USD_INCLUDE_DIR}/pxr/base/tf/pyModule.h)
       set(USD_PYTHON_SUPPORT ON)
     endif()
