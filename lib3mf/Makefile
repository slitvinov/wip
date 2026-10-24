# $NetBSD$

DISTNAME=	lib3mf-2.5.0
CATEGORIES=	cad graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=3MFConsortium/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://3mf.io/
COMMENT=	Implementation of the 3D Manufacturing Format (3MF) file standard
LICENSE=	2-clause-bsd

USE_LANGUAGES=	c c++
USE_TOOLS+=	pkg-config

# The release tarball has no git submodules; use pkgsrc zlib, libzip
# and fast_float instead (cpp-base64 is vendored under Libraries/).
# The tests need the googletest submodule.
CMAKE_CONFIGURE_ARGS+=	-DUSE_INCLUDED_ZLIB=OFF
CMAKE_CONFIGURE_ARGS+=	-DUSE_INCLUDED_LIBZIP=OFF
CMAKE_CONFIGURE_ARGS+=	-DUSE_INCLUDED_FASTFLOAT=OFF
CMAKE_CONFIGURE_ARGS+=	-DLIB3MF_TESTS=OFF

PKGCONFIG_OVERRIDE+=	lib3mf.pc.in

.include "../../devel/cmake/build.mk"
.include "../../archivers/libzip/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../math/fast_float/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
