$NetBSD$

Fall back to pkgsrc's ffmpeg7/ffprobe7 (installed with a version suffix)
when no ffmpeg or ffprobe is on PATH.

--- pydub/utils.py.orig
+++ pydub/utils.py
@@ -165,6 +165,8 @@
         return "avconv"
     elif which("ffmpeg"):
         return "ffmpeg"
+    elif os.access("@FFMPEG@", os.X_OK):
+        return "@FFMPEG@"
     else:
         # should raise exception
         warn("Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work", RuntimeWarning)
@@ -193,6 +195,8 @@
         return "avprobe"
     elif which("ffprobe"):
         return "ffprobe"
+    elif os.access("@FFPROBE@", os.X_OK):
+        return "@FFPROBE@"
     else:
         # should raise exception
         warn("Couldn't find ffprobe or avprobe - defaulting to ffprobe, but may not work", RuntimeWarning)
