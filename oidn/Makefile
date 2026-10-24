# $NetBSD$

DISTNAME=	oidn-2.5.0.src
PKGNAME=	${DISTNAME:S/.src//}
CATEGORIES=	graphics
# The release tarball includes the trained weights (a git submodule).
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/oidn/releases/download/v${PKGVERSION_NOREV}/}
WRKSRC=		${WRKDIR}/oidn-${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.openimagedenoise.org/
COMMENT=	Intel Open Image Denoise, denoising filters for ray tracing
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

# Settings follow Blender's build_files/build_environment/cmake/openimagedenoise.cmake.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DOIDN_APPS=OFF
CMAKE_CONFIGURE_ARGS+=	-DOIDN_FILTER_RTLIGHTMAP=OFF
CMAKE_CONFIGURE_ARGS+=	-DOIDN_DEVICE_CPU=ON
# The Metal device needs the Metal shader compiler (full Xcode) at build
# time, which the Command Line Tools do not provide.
CMAKE_CONFIGURE_ARGS+=	-DOIDN_DEVICE_METAL=OFF
CMAKE_CONFIGURE_ARGS+=	-DOIDN_DEVICE_SYCL=OFF
CMAKE_CONFIGURE_ARGS+=	-DOIDN_DEVICE_CUDA=OFF
CMAKE_CONFIGURE_ARGS+=	-DOIDN_DEVICE_HIP=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_EXECUTABLE=${TOOLBASE}/bin/ispc
CMAKE_CONFIGURE_ARGS+=	-DPython_EXECUTABLE=${PYTHONBIN}
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

PYTHON_FOR_BUILD_ONLY=	tool
TOOL_DEPENDS+=		ispc>=1.21:../../wip/ispc

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
.include "../../lang/python/tool.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
