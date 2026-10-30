# $NetBSD$

DISTNAME=	openpgl-0.7.1
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=OpenPathGuidingLibrary/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/OpenPathGuidingLibrary/openpgl
COMMENT=	Open Path Guiding Library for Monte Carlo renderers
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++11

# Settings follow Blender's build_files/build_environment/cmake/openpgl.cmake,
# except that a shared library is built.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DOPENPGL_BUILD_STATIC=OFF
CMAKE_CONFIGURE_ARGS+=	-DOPENPGL_BUILD_TOOLS=OFF
CMAKE_CONFIGURE_ARGS+=	-DOPENPGL_TBB_ROOT=${BUILDLINK_PREFIX.threadingbuildingblocks}
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
