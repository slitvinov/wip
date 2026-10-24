# $NetBSD$

DISTNAME=	ospray-studio-1.1.0
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.ospray.org/ospray_studio/
COMMENT=	Interactive scene graph viewer built on OSPRay
LICENSE=	apache-2.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
# Do not copy the OSPRay libraries into this package.
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_INSTALL=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_APPS=ON
CMAKE_CONFIGURE_ARGS+=	-DBUILD_PLUGINS=OFF
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
CMAKE_CONFIGURE_ARGS+=	-DUSE_BENCHMARK=ON
CMAKE_CONFIGURE_ARGS+=	-DUSE_MPI=OFF
# The Python scene graph module (pybind11) is left out for now.
CMAKE_CONFIGURE_ARGS+=	-DUSE_PYSG=OFF
# Textures load through the bundled stb_image and tinyexr.
CMAKE_CONFIGURE_ARGS+=	-DENABLE_OPENIMAGEIO=OFF
CMAKE_CONFIGURE_ARGS+=	-DENABLE_EXR=OFF
CMAKE_CONFIGURE_ARGS+=	-DENABLE_OPENVDB=OFF
CMAKE_CONFIGURE_ARGS+=	-DENABLE_GLTF_DRACO=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
.include "../../wip/ospray/buildlink3.mk"
.include "../../graphics/glfw/buildlink3.mk"
.include "../../benchmarks/google-benchmark/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
