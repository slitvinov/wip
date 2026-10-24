# $NetBSD$

DISTNAME=	openvkl-2.0.2
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.openvkl.org/
COMMENT=	Intel Open Volume Kernel Library
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++11

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DISPC_EXECUTABLE=${TOOLBASE}/bin/ispc
# The GPU device needs Intel's SYCL compiler and an Intel GPU.
CMAKE_CONFIGURE_ARGS+=	-DOPENVKL_ENABLE_DEVICE_GPU=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_EXAMPLES=ON
CMAKE_CONFIGURE_ARGS+=	-DBUILD_BENCHMARKS=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

.include "../../mk/bsd.prefs.mk"
.if ${MACHINE_ARCH} == "aarch64"
# Only one NEON width can be built.  Use the 8-wide (double-pumped)
# target, which matches Embree's NEON2X build and is the one OSPRay
# needs to pair with it.
CMAKE_CONFIGURE_ARGS+=	-DOPENVKL_ISA_NEON=OFF
CMAKE_CONFIGURE_ARGS+=	-DOPENVKL_ISA_NEON2X=ON
.endif

TOOL_DEPENDS+=		ispc>=1.30:../../wip/ispc

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
BUILDLINK_API_DEPENDS.embree+=	embree>=4.4.1nb1
.include "../../wip/embree/buildlink3.mk"
.include "../../wip/rkcommon/buildlink3.mk"
.include "../../graphics/glfw/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
