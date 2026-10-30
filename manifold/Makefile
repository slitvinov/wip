# $NetBSD$

DISTNAME=	manifold-3.5.2
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=elalish/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/elalish/manifold
COMMENT=	Robust boolean operations on triangle meshes
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

# Settings follow Blender's build_files/build_environment/cmake/manifold.cmake,
# except that a shared library is built. 3.5.2 is Blender 5.2's version.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DBUILD_SHARED_LIBS=ON
# Parallel (TBB) backend.
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_PAR=ON
# 2D cross sections (and the C bindings that need them) would require
# Clipper2, which is not in pkgsrc; Blender does not use them.
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_CROSS_SECTION=OFF
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_CBIND=OFF
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_PYBIND=OFF
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_JSBIND=OFF
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_TEST=OFF
# Never fetch dependencies at build time.
CMAKE_CONFIGURE_ARGS+=	-DMANIFOLD_DOWNLOADS=OFF
CMAKE_CONFIGURE_ARGS+=	-DTRACY_ENABLE=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
