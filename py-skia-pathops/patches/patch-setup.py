$NetBSD$

Do not download virtualenv, ninja or gn while building the bundled Skia:
use pkgsrc's gn (wip/gn-git) and ninja (devel/ninja-build).

--- setup.py.orig
+++ setup.py
@@ -274,6 +274,8 @@
 
     if inside_sdist:
         build_cmd.append("--no-sync-deps")
+    # pkgsrc: no downloads; use pkgsrc's gn and the ninja on PATH
+    build_cmd.extend(["--no-virtualenv", "--no-fetch-gn", "--gn-path", "@GN@"])
 
     env = os.environ
     target_cpu = None
