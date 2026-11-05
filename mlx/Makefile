# $NetBSD$

DISTNAME=	mlx-0.32.4
CATEGORIES=	math
MASTER_SITES=	${MASTER_SITE_GITHUB:=ml-explore/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

# Dependencies that MLX would fetch with FetchContent at configure time,
# at the versions pinned by its CMake files.  metal-cpp provides the C++
# Metal API headers; gguf-tools reads GGUF model files.
METAL_CPP_DISTFILE=		metal-cpp_26.zip
JSON_DISTFILE=			nlohmann-json-3.11.3.tar.xz
GGUF_REV=			8fa6eb65236618e28fd7710a0fba565f7faa1848
GGUF_DISTFILE=			gguf-tools-${GGUF_REV}.tar.gz
DISTFILES=			${DEFAULT_DISTFILES} ${METAL_CPP_DISTFILE}
DISTFILES+=			${JSON_DISTFILE} ${GGUF_DISTFILE}
SITES.${METAL_CPP_DISTFILE}=	https://developer.apple.com/metal/cpp/files/
SITES.${JSON_DISTFILE}=		-https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz
SITES.${GGUF_DISTFILE}=		-https://github.com/antirez/gguf-tools/archive/${GGUF_REV}.tar.gz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/ml-explore/mlx
COMMENT=	Array framework for machine learning on Apple silicon
LICENSE=	mit AND apache-2.0

# The Metal (GPU) backend and Accelerate (BLAS/LAPACK) are macOS-only, and
# MLX's Metal backend requires Apple silicon.
ONLY_FOR_PLATFORM=	Darwin-*-aarch64

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++20
USE_TOOLS+=		bash

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DBUILD_SHARED_LIBS=ON
CMAKE_CONFIGURE_ARGS+=	-DMLX_BUILD_TESTS=OFF
CMAKE_CONFIGURE_ARGS+=	-DMLX_BUILD_EXAMPLES=OFF
CMAKE_CONFIGURE_ARGS+=	-DMLX_BUILD_BENCHMARKS=OFF
CMAKE_CONFIGURE_ARGS+=	-DMLX_BUILD_PYTHON_BINDINGS=OFF
# Command Line Tools lack the offline metal shader compiler (it ships with
# Xcode only), so compile every Metal kernel at run time from embedded
# source through the Metal API (patched-in option; implies MLX_METAL_JIT).
# The first use of a kernel costs a compile; the system Metal shader cache
# makes later processes fast.
CMAKE_CONFIGURE_ARGS+=	-DMLX_METAL_RUNTIME_COMPILE=ON
# CMAKE_OSX_DEPLOYMENT_TARGET is left unset: MLX then targets the running
# macOS, and the M5 neural accelerator (NAX) matmul and attention kernels
# require 26.2 or later.
# pkgsrc's compiler wrappers already use ccache when it is enabled.
CMAKE_CONFIGURE_ARGS+=	-DMLX_USE_CCACHE=OFF
CMAKE_CONFIGURE_ARGS+=	-DUSE_SYSTEM_FMT=ON
# Never download during the build: use the extracted distfiles.
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_FULLY_DISCONNECTED=ON
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_SOURCE_DIR_METAL_CPP=${WRKDIR}/metal-cpp
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_SOURCE_DIR_JSON=${WRKDIR}/json
CMAKE_CONFIGURE_ARGS+=	-DFETCHCONTENT_SOURCE_DIR_GGUFLIB=${WRKDIR}/gguf-tools-${GGUF_REV}
# Newer install_name_tool fails to delete the build RPATH on Darwin; use
# absolute install names so that dependent packages find the libraries.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_INSTALL_NAME_DIR=${PREFIX}/lib

LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names

.include "../../devel/cmake/build.mk"
.include "../../textproc/fmtlib/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
