$NetBSD$

OSPRay 3.2 generates MIP maps for all textures.  VTK colours scalars
through a 258x2 colour-map texture whose second row holds the NaN
colour; sampling the lower MIP levels mixes that row in and posterizes
the colours (surfaces come out banded and washed out).  Disable MIP map
generation on the device.

--- VTK/Rendering/RayTracing/RTWrapper/OSPRay/OSPRayBackend.h.orig
+++ VTK/Rendering/RayTracing/RTWrapper/OSPRay/OSPRayBackend.h
@@ -3,6 +3,7 @@
 #pragma once
 
 #include <ospray/ospray_util.h>
+#include <ospray/version.h>
 
 #include "../Backend.h"
 
@@ -87,6 +88,14 @@
         ospDeviceSetErrorCallback(device, [](void *, OSPError, const char *errorDetails) {
           std::cerr << "OSPRay ERROR: " << errorDetails << std::endl;
         }, nullptr);
+#if OSPRAY_VERSION_MAJOR > 3 || (OSPRAY_VERSION_MAJOR == 3 && OSPRAY_VERSION_MINOR >= 2)
+        // MIP maps (new in OSPRay 3.2) blur the 258x2 colour-map textures
+        // used for scalar colouring: lower levels mix the NaN row in and
+        // posterize the colours.
+        bool disableMipMaps = true;
+        ospDeviceSetParam(device, "disableMipMapGeneration", OSP_BOOL, &disableMipMaps);
+        ospDeviceCommit(device);
+#endif
         once = true;
       }
       return ret;
