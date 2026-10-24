$NetBSD$

Load pkgsrc's GLFW library (graphics/glfw) by default instead of
searching sys.prefix, /usr and Homebrew paths for the newest libglfw.
PYGLFW_LIBRARY still overrides it.

--- glfw/library.py.orig
+++ glfw/library.py
@@ -225,9 +225,9 @@
         return os.path.join(package_path, 'x11')
 
 
-if os.environ.get('PYGLFW_LIBRARY', ''):
+if os.environ.get('PYGLFW_LIBRARY', '@GLFW_LIBRARY@'):
     try:
-        glfw = ctypes.CDLL(os.environ['PYGLFW_LIBRARY'])  # type: ctypes.CDLL | None
+        glfw = ctypes.CDLL(os.environ.get('PYGLFW_LIBRARY', '@GLFW_LIBRARY@'))  # type: ctypes.CDLL | None
     except OSError:
         glfw = None
 elif sys.platform == 'win32':
