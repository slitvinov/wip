# $NetBSD$

DISTNAME=	ispc-1.30.0
CATEGORIES=	lang devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=ispc/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://ispc.github.io/
COMMENT=	Intel Implicit SPMD Program Compiler
LICENSE=	modified-bsd

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		bison flex m4

# Only the compiler is needed (e.g. by OpenImageDenoise); no runtime,
# examples, tests, utilities or library.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DISPC_INCLUDE_EXAMPLES=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_INCLUDE_TESTS=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_INCLUDE_BENCHMARKS=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_INCLUDE_RT=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_INCLUDE_UTILS=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_LIBRARY=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_LIBRARY_JIT=OFF
CMAKE_CONFIGURE_ARGS+=	-DISPC_STATIC_LINK=OFF
CMAKE_CONFIGURE_ARGS+=	-DGIT_BINARY=GIT_BINARY-NOTFOUND
# ISPC compiles its builtins with the clang/llvm-as matching its LLVM.
CMAKE_CONFIGURE_ARGS+=	-DLLVM_CONFIG_EXECUTABLE=${BUILDLINK_PREFIX.llvm}/bin/llvm-config
CMAKE_CONFIGURE_ARGS+=	-DPython3_EXECUTABLE=${PYTHONBIN}
CMAKE_CONFIGURE_ARGS+=	-DBISON_EXECUTABLE=${TOOLS_PATH.bison}
CMAKE_CONFIGURE_ARGS+=	-DFLEX_EXECUTABLE=${TOOLS_PATH.flex}

.include "../../mk/bsd.prefs.mk"
.if ${MACHINE_ARCH} == "aarch64"
CMAKE_CONFIGURE_ARGS+=	-DARM_ENABLED=ON
.endif

PYTHON_FOR_BUILD_ONLY=	tool

CMAKE_GENERATOR=	ninja
.include "../../devel/cmake/build.mk"
.include "../../lang/python/tool.mk"
.include "../../lang/clang/buildlink3.mk"
.include "../../lang/llvm/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
