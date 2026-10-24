$NetBSD$

Include tbb/version.h explicitly: with oneTBB 2023 tbb/blocked_range.h
no longer defines TBB_INTERFACE_VERSION, so the removed tbb::task::self()
API was selected.

--- openvdb/openvdb/thread/Threading.h.orig
+++ openvdb/openvdb/thread/Threading.h
@@ -21,6 +21,7 @@
 ///   access the version defines in a consistent way so that downstream
 ///   software doesn't need to provide compile time defines.
 #include <tbb/blocked_range.h>
+#include <tbb/version.h> // pkgsrc: oneTBB >= 2022 no longer includes it via blocked_range.h
 #include <tbb/task.h>
 #include <tbb/task_group.h>
 
