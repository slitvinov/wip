# $NetBSD$

DISTNAME=	openvdb-${PKGVERSION}
PKGVERSION=	12.1.1
# NanoVDB headers added.
PKGREVISION=	1
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=AcademySoftwareFoundation/}
GITHUB_PROJECT=	openvdb
GITHUB_TAG=	v${PKGVERSION}

MAINTAINER=	stix@stix.id.au
HOMEPAGE=	https://www.openvdb.org/
COMMENT=	Efficient storage and manipulation of sparse volumetric data
LICENSE=	mpl-2.0

USE_LANGUAGES=	c c++
GCC_REQD+=	11.3
USE_TOOLS+=	gmake pkg-config
CONFIGURE_DIRS=	build
CMAKE_ARG_PATH=	..

# NanoVDB (header-only, shipped with OpenVDB) is needed for GPU volume
# rendering in e.g. Blender's Cycles.
CMAKE_CONFIGURE_ARGS+=	-DUSE_NANOVDB=ON
CMAKE_CONFIGURE_ARGS+=	-DUSE_CCACHE=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

pre-configure:
	cd ${WRKSRC} && mkdir build

.include "../../devel/blosc/buildlink3.mk"
.include "../../devel/boost-headers/buildlink3.mk"
.include "../../devel/boost-libs/buildlink3.mk"
.include "../../devel/cmake/build.mk"
.include "../../devel/jemalloc/buildlink3.mk"
.include "../../graphics/openexr/buildlink3.mk"
.include "../../math/imath/buildlink3.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
