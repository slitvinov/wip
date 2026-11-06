$NetBSD$

Install the plugin directory's plugInfo.json into lib/usd/plugin.

--- cmake/macros/Public.cmake.orig
+++ cmake/macros/Public.cmake
@@ -1095,7 +1095,7 @@
          "${plugInfoContents}")
     install(
         FILES "${CMAKE_CURRENT_BINARY_DIR}/usd_plugInfo.json"
-        DESTINATION plugin/usd
+        DESTINATION lib/usd/plugin
         RENAME "plugInfo.json"
     )
 
