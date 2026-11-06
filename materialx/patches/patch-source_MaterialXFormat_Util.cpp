$NetBSD$

Fall back to the installed data library in share/MaterialX when none is
found next to the executable (pkgsrc does not install it at PREFIX/libraries).

--- source/MaterialXFormat/Util.cpp.orig
+++ source/MaterialXFormat/Util.cpp
@@ -258,6 +258,10 @@
             break;
         }
         currentPath = currentPath.getParentPath();
+    }
+    if (searchPath.isEmpty())
+    {
+        searchPath.append(FilePath("@PREFIX@/share/MaterialX"));
     }
     return searchPath;
 }
