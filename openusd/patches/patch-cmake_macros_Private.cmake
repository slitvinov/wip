$NetBSD$

Install plugins into lib/usd/plugin instead of the top-level
PREFIX/plugin/usd, and look for them there (relative to lib).

--- cmake/macros/Private.cmake.orig
+++ cmake/macros/Private.cmake
@@ -1198,7 +1198,7 @@
         _get_install_dir("plugin" pluginInstallPrefix)
         if (NOT PXR_INSTALL_SUBDIR)
             # XXX --- Why this difference?
-            _get_install_dir("plugin/usd" pluginInstallPrefix)
+            _get_install_dir("lib/usd/plugin" pluginInstallPrefix)
         endif()
     else()
         _get_install_dir("lib/usd" pluginInstallPrefix)
@@ -1367,7 +1367,7 @@
             MFB_ALT_PACKAGE_NAME=${PXR_PACKAGE}
             MFB_PACKAGE_MODULE=${pythonModuleName}
             PXR_BUILD_LOCATION=usd
-            PXR_PLUGIN_BUILD_LOCATION=../plugin/usd
+            PXR_PLUGIN_BUILD_LOCATION=usd/plugin
             ${pxrInstallLocation}
             ${apiPrivate}
     )
