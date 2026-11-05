$NetBSD$

Support Eigen 3.4 (pkgsrc math/eigen3), which lacks the compile-time
JacobiSVD options API; the run-time options form works with Eigen 3.4
and 5.

--- intern/libmv/libmv/tracking/track_region.cc.orig
+++ intern/libmv/libmv/tracking/track_region.cc
@@ -940,7 +940,7 @@
     }
 
     // TODO(keir): Check solution quality.
-    Vec4 a = Q1.jacobiSvd<Eigen::ComputeThinU | Eigen::ComputeThinV>().solve(Q2);
+    Vec4 a = Q1.jacobiSvd(Eigen::ComputeThinU | Eigen::ComputeThinV).solve(Q2);
     parameters[2] = a[0];
     parameters[3] = a[1];
     parameters[4] = a[2];
