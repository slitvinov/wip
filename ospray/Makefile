# $NetBSD$

DISTNAME=	ospray-3.2.0
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_GITHUB:=RenderKit/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.ospray.org/
COMMENT=	Intel OSPRay, ray tracing based rendering engine
LICENSE=	apache-2.0

# The apps fetch Dear ImGui (patched) and stb at configure time with
# FetchContent; ship the same commits as distfiles instead.
IMGUI_COMMIT=		cb16be3a3fc1f9cd146ae24d52b615f8a05fa93d
STB_COMMIT=		013ac3beddff3dbffafd5177e7972067cd2b5083
IMGUI_DIST=		imgui-${IMGUI_COMMIT}.tar.gz
STB_DIST=		stb-${STB_COMMIT}.tar.gz
DISTFILES=		${DEFAULT_DISTFILES} ${IMGUI_DIST} ${STB_DIST}
SITES.${IMGUI_DIST}=	-https://github.com/ocornut/imgui/archive/${IMGUI_COMMIT}.tar.gz
SITES.${STB_DIST}=	-https://github.com/nothings/stb/archive/${STB_COMMIT}.tar.gz

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		patch

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DISPC_EXECUTABLE=${TOOLBASE}/bin/ispc
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_FULLY_DISCONNECTED=ON
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_SOURCE_DIR_IMGUI=${WRKDIR}/imgui-${IMGUI_COMMIT}
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_SOURCE_DIR_STB=${WRKDIR}/stb-${STB_COMMIT}
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_CPU=ON
# The GPU (SYCL) device needs Intel's oneAPI DPC++ compiler and an
# Intel GPU; the multidevice module is only useful with it.
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_GPU=OFF
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_MULTIDEVICE=OFF
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_DENOISER=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_MPI=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_MODULE_BILINEAR_PATCH=OFF
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_VOLUMES=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_APPS=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_APPS_BENCHMARK=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_APPS_EXAMPLES=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_APPS_TUTORIALS=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_ENABLE_APPS_TESTING=ON
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_APPS_ENABLE_GLM=OFF
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_INSTALL_DEPENDENCIES=OFF
# Newer install_name_tool fails to delete the build RPATH on Darwin.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
# Point FindMPI at the pkgsrc Open MPI wrappers.
CMAKE_CONFIGURE_ARGS+=	-DMPI_C_COMPILER=${BUILDLINK_PREFIX.openmpi}/bin/mpicc
CMAKE_CONFIGURE_ARGS+=	-DMPI_CXX_COMPILER=${BUILDLINK_PREFIX.openmpi}/bin/mpicxx

.include "../../mk/bsd.prefs.mk"
.if ${MACHINE_ARCH} == "aarch64"
# Embree and Open VKL are built for NEON2X (neon-i32x8) only.
CMAKE_CONFIGURE_ARGS+=	-DOSPRAY_BUILD_ISA=NEON2X
.endif

TOOL_DEPENDS+=		ispc>=1.30:../../wip/ispc

# FetchContent would apply this with git; apply it with patch(1).
post-patch:
	cd ${WRKDIR}/imgui-${IMGUI_COMMIT} && \
	${PATCH} -p1 -s < ${WRKSRC}/apps/common/external/imgui/imgui.patch

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
.include "../../wip/openvkl/buildlink3.mk"
.include "../../wip/embree/buildlink3.mk"
.include "../../wip/rkcommon/buildlink3.mk"
.include "../../wip/oidn/buildlink3.mk"
# MPI distributed rendering module.
.include "../../parallel/openmpi/buildlink3.mk"
.include "../../devel/snappy/buildlink3.mk"
.include "../../graphics/glfw/buildlink3.mk"
# ospTestSuite and ospBenchmark (static libraries, build only).
.include "../../devel/googletest/buildlink3.mk"
.include "../../benchmarks/google-benchmark/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
