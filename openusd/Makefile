# $NetBSD$

DISTNAME=	OpenUSD-26.08
PKGNAME=	${DISTNAME:tl}
PKGREVISION=	2
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=PixarAnimationStudios/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://openusd.org/
COMMENT=	Universal Scene Description: 3D scene interchange and composition
LICENSE=	tost-1.0

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_TESTS=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_EXAMPLES=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_TUTORIALS=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_DOCUMENTATION=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_IMAGING=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_USD_IMAGING=ON
# usdview needs PySide6 and PyOpenGL.
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_USDVIEW=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_MATERIALX_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_MATERIALX_STDLIB_INSTALL_DIR=${PREFIX}/share/MaterialX/libraries
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_OPENVDB_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_PTEX_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_OPENIMAGEIO_PLUGIN=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_OPENCOLORIO_PLUGIN=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_ALEMBIC_PLUGIN=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_DRACO_PLUGIN=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_EMBREE_PLUGIN=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_OSL_SUPPORT=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_BUILD_PRMAN_PLUGIN=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_PRECOMPILED_HEADERS=OFF
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_COMPILER_CACHE=OFF

.include "../../mk/bsd.prefs.mk"
.include "options.mk"

.if ${OPSYS} == "Darwin"
# Hydra Storm renders through Metal (HgiMetal compiles its shaders at
# run time, so the offline metal compiler is not needed).
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_METAL_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_INSTALL_NAME_DIR=${PREFIX}/lib
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
.endif

# The CMake package files record buildlink paths of dependencies.
SUBST_CLASSES+=		bl
SUBST_STAGE.bl=		post-build
SUBST_MESSAGE.bl=	Replacing buildlink paths in the CMake package files.
SUBST_FILES.bl=		${CMAKE_BUILD_DIR}/pxrConfig.cmake
SUBST_FILES.bl+=	${CMAKE_BUILD_DIR}/pxr/CMakeFiles/Export/*/pxrTargets.cmake
SUBST_SED.bl=		-e 's,${BUILDLINK_DIR},${PREFIX},g'

.include "../../devel/cmake/build.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../wip/opensubdiv/buildlink3.mk"
.include "../../wip/materialx/buildlink3.mk"
.include "../../graphics/openimageio/buildlink3.mk"
.include "../../graphics/opencolorio/buildlink3.mk"
.include "../../graphics/ptex/buildlink3.mk"
.include "../../wip/openvdb/buildlink3.mk"
.include "../../wip/alembic/buildlink3.mk"
.include "../../geography/draco/buildlink3.mk"
.include "../../wip/embree/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
