$NetBSD$

NetBSD has statvfs(2) instead of statfs(2); use it there and skip the
NFS check (it uses statfs).  Other systems are unchanged.

--- VTK/ThirdParty/ioss/vtkioss/Ioss_FileInfo.C.orig
+++ VTK/ThirdParty/ioss/vtkioss/Ioss_FileInfo.C
@@ -30,7 +30,9 @@
 #endif
 #else
 #include <unistd.h>
-#if defined(__APPLE__) || defined(__FreeBSD__) || defined(__NetBSD__)
+#if defined(__NetBSD__)
+#include <sys/statvfs.h>
+#elif defined(__APPLE__) || defined(__FreeBSD__)
 #include <sys/mount.h>
 #elif defined(__OpenBSD__)
 #include <sys/mount.h>
@@ -179,9 +181,15 @@
     char *path = ::realpath(tmp_path.c_str(), nullptr);
     if (path != nullptr) {
 
+#if defined(__NetBSD__)
+      struct statvfs stat_fs;
+      // We want to run `statfs` on the path; not the filename since it might not exist.
+      if (statvfs(path, &stat_fs) == -1) {
+#else
       struct statfs stat_fs;
       // We want to run `statfs` on the path; not the filename since it might not exist.
       if (statfs(path, &stat_fs) == -1) {
+#endif
         free(path);
         std::ostringstream errmsg;
         errmsg << "ERROR: Could not run statfs on '" << filename_ << "'.\n";
@@ -208,7 +216,7 @@
   //: Return TRUE if file is on an NFS filesystem...
   bool FileInfo::is_nfs() const
   {
-#if !defined(__IOSS_WINDOWS__)
+#if !defined(__IOSS_WINDOWS__) && !defined(__NetBSD__)
     auto tmp_path = pathname();
     if (tmp_path.empty()) {
       char *current_cwd = getcwd(nullptr, 0);
