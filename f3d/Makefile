# $NetBSD$

DISTNAME=	f3d-4.0.1
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=f3d-app/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://f3d.app/
COMMENT=	Fast and minimalist 3D viewer
LICENSE=	modified-bsd

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DBUILD_TESTING=OFF
# Plain Unix layout (bin/f3d, lib/, share/f3d) instead of an app bundle.
CMAKE_CONFIGURE_ARGS+=	-DF3D_MACOS_BUNDLE=OFF
CMAKE_CONFIGURE_ARGS+=	-DF3D_BINDINGS_PYTHON=ON
CMAKE_CONFIGURE_ARGS+=	-Dpybind11_DIR=${BUILDLINK_PREFIX.py-pybind11}/${PYSITELIB}/pybind11/share/cmake/pybind11
CMAKE_CONFIGURE_ARGS+=	-DF3D_BINDINGS_PYTHON_GENERATE_STUBS=OFF
CMAKE_CONFIGURE_ARGS+=	-DF3D_LINUX_GENERATE_MAN=OFF
CMAKE_CONFIGURE_ARGS+=	-DF3D_MODULE_EXR=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_MODULE_WEBP=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_MODULE_UI=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_ALEMBIC=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_ASSIMP=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_DRACO=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_HDF=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_OCCT=ON
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_USD=ON
# Needs VTK's IOOpenVDB module, which graphics/vtk does not build.
CMAKE_CONFIGURE_ARGS+=	-DF3D_PLUGIN_BUILD_VDB=OFF

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_INSTALL_NAME_DIR=${PREFIX}/lib
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
.endif

PY_PATCHPLIST=	yes

.include "../../devel/cmake/build.mk"
.include "../../lang/python/extension.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.include "../../graphics/vtk/buildlink3.mk"
.include "../../graphics/openexr/buildlink3.mk"
.include "../../graphics/libwebp/buildlink3.mk"
.include "../../wip/alembic/buildlink3.mk"
.include "../../multimedia/assimp/buildlink3.mk"
.include "../../geography/draco/buildlink3.mk"
.include "../../wip/occt/buildlink3.mk"
.include "../../wip/openusd/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
