# $NetBSD$

# Development snapshot after 2.2.0: Blender 5.2 builds against this
# commit, which replaced glog with Abseil logging (so Ceres no longer
# clashes with the glog bundled in Blender's libmv).
CERES_COMMIT=	0c70ed3a1a2d6ba47c06c7e8b3b040880bc474db
DISTNAME=	ceres-solver-2.2.0.20251205
CATEGORIES=	math
MASTER_SITES=	${MASTER_SITE_GITHUB:=ceres-solver/}
GITHUB_PROJECT=	ceres-solver
GITHUB_TAG=	${CERES_COMMIT}
WRKSRC=		${WRKDIR}/ceres-solver-${CERES_COMMIT}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	http://ceres-solver.org/
COMMENT=	Nonlinear least squares and optimization library
LICENSE=	modified-bsd

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

# Settings follow Blender's build_files/build_environment/cmake/ceres.cmake.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DBUILD_SHARED_LIBS=ON
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_EXAMPLES=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_BENCHMARKS=OFF
CMAKE_CONFIGURE_ARGS+=	-DPROVIDE_UNINSTALL_TARGET=OFF
CMAKE_CONFIGURE_ARGS+=	-DUSE_CUDA=OFF
# Use Eigen for dense and sparse linear algebra, as Blender's build does;
# SuiteSparse and LAPACK would add large dependencies for no benefit to
# the small problems solved by camera tracking.
CMAKE_CONFIGURE_ARGS+=	-DSUITESPARSE=OFF
CMAKE_CONFIGURE_ARGS+=	-DLAPACK=OFF
CMAKE_CONFIGURE_ARGS+=	-DEIGENMETIS=OFF
# Accelerate's sparse solvers are not detected with the macOS Command
# Line Tools SDK anyway; keep the result independent of the SDK.
CMAKE_CONFIGURE_ARGS+=	-DACCELERATESPARSE=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

.include "../../devel/cmake/build.mk"
.include "../../devel/abseil/buildlink3.mk"
.include "../../math/eigen3/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
