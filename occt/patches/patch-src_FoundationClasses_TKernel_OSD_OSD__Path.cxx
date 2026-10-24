$NetBSD$

NetBSD support

--- src/FoundationClasses/TKernel/OSD/OSD_Path.cxx.orig	2026-10-24 09:37:02
+++ src/FoundationClasses/TKernel/OSD/OSD_Path.cxx
@@ -19,7 +19,7 @@
 static OSD_SysType whereAmI()
 {
 #if defined(__digital__) || defined(__FreeBSD__) || defined(SUNOS) || defined(__APPLE__)           \
-  || defined(__QNX__) || defined(__FreeBSD_kernel__)
+  || defined(__QNX__) || defined(__FreeBSD_kernel__) || defined(__NetBSD__)
   return OSD_UnixBSD;
 #elif defined(sgi) || defined(IRIX) || defined(__sun) || defined(SOLARIS) || defined(__sco__)      \
   || defined(__hpux) || defined(HPUX)
