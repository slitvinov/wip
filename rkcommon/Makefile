# $NetBSD$

DISTNAME=	rkcommon-1.15.4
CATEGORIES=	devel graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/RenderKit/rkcommon
COMMENT=	Common C++/CMake infrastructure of the Intel Render Kit
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++11

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DRKCOMMON_TASKING_SYSTEM=TBB
# The tests download Catch2 at configure time.
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
