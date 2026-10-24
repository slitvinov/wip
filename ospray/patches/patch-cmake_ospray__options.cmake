$NetBSD$

Accept rkcommon newer than 1.14.0 (Open VKL 2.0.2 needs >= 1.15.2).
The 1.15 series only drops the unused XML parser, which OSPRay does
not use.

--- cmake/ospray_options.cmake.orig	2026-10-24 14:20:48
+++ cmake/ospray_options.cmake	2026-10-24 14:20:48
@@ -76,7 +76,7 @@
 ###########################################################
 
 # rkcommon
-find_package(rkcommon ${RKCOMMON_VERSION_REQUIRED} EXACT REQUIRED)
+find_package(rkcommon ${RKCOMMON_VERSION_REQUIRED} REQUIRED)
 get_target_property(RKCOMMON_INCLUDE_DIRS rkcommon::rkcommon
   INTERFACE_INCLUDE_DIRECTORIES)
 
