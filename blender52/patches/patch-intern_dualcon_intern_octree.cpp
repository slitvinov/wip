$NetBSD$

Support Eigen 3.4 (pkgsrc math/eigen3), which lacks the compile-time
JacobiSVD options API.

--- intern/dualcon/intern/octree.cpp.orig
+++ intern/dualcon/intern/octree.cpp
@@ -2184,7 +2184,12 @@
 static void pseudoInverse(const Eigen::Matrix3f &a, Eigen::Matrix3f &result, float tolerance)
 {
   const int Options = Eigen::ComputeFullU | Eigen::ComputeFullV;
+#if EIGEN_VERSION_AT_LEAST(3, 4, 90)
   Eigen::JacobiSVD<Eigen::Matrix3f, Options> svd = a.jacobiSvd<Options>();
+#else
+  /* Eigen 3.4 and older only take the options at run-time. */
+  Eigen::JacobiSVD<Eigen::Matrix3f> svd = a.jacobiSvd(Options);
+#endif
 
   result = svd.matrixV() *
            Eigen::Vector3f((svd.singularValues().array().abs() > tolerance)
