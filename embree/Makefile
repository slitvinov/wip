# $NetBSD$

DISTNAME=	embree-4.4.1
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/}
GITHUB_TAG=	v${PKGVERSION_NOREV}
PKGREVISION=	1

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.embree.org/
COMMENT=	High performance ray tracing kernels
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++11

# Settings follow Blender's build_files/build_environment/cmake/embree.cmake.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
# ISPC support only installs the .isph headers and marks it in
# embree-config.cmake; OSPRay and Open VKL refuse an Embree without it.
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_ISPC_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_ISPC_EXECUTABLE=${TOOLBASE}/bin/ispc
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_TUTORIALS=OFF
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_STATIC_LIB=OFF
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_RAY_MASK=ON
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_FILTER_FUNCTION=ON
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_BACKFACE_CULLING=OFF
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_BACKFACE_CULLING_CURVES=ON
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_BACKFACE_CULLING_SPHERES=ON
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_TASKING_SYSTEM=TBB
# Install into the regular prefix layout, not a relocatable ZIP layout.
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_ZIP_MODE=OFF
CMAKE_CONFIGURE_ARGS+=	-DEMBREE_INSTALL_DEPENDENCIES=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

TOOL_DEPENDS+=	ispc>=1.21:../../wip/ispc

.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
