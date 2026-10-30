# $NetBSD$

DISTNAME=	meshoptimizer-1.1
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=zeux/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://meshoptimizer.org/
COMMENT=	Mesh optimization and compression library
LICENSE=	mit

USE_LANGUAGES=	c c++

# 1.1 is the version Blender 5.2 is built against upstream.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DMESHOPT_BUILD_SHARED_LIBS=ON
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

.include "../../devel/cmake/build.mk"
.include "../../mk/bsd.pkg.mk"
