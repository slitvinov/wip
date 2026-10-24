# $NetBSD$

DISTNAME=	drjit-1.5.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_GITHUB:=mitsuba-renderer/}
GITHUB_PROJECT=	drjit
GITHUB_TAG=	v${PKGVERSION_NOREV}

# Git submodules pinned by the v1.5.0 tag.  robin-map is the Mitsuba fork:
# drjit-core uses its hash-aware insert functions (try_emplace_hash() etc.),
# which devel/robin-map 1.4.1 lacks.  nanobind must be exactly 2.14.0
# (devel/py-nanobind is 3.x) because Mitsuba's extension shares Dr.Jit's
# nanobind domain and both must agree on its internal ABI.
GITHUB_SUBMODULES+=	mitsuba-renderer drjit-core 3b96411288b9938889045308654ba37d4ef24b71 ext/drjit-core
GITHUB_SUBMODULES+=	mitsuba-renderer nanothread a2097209e10852962c485ee46d84d28e7a63a1a1 ext/drjit-core/ext/nanothread
GITHUB_SUBMODULES+=	mitsuba-renderer cmake-defaults d65442956cd78772ba26ba25dc552de22566b717 ext/drjit-core/ext/nanothread/ext/cmake-defaults
GITHUB_SUBMODULES+=	mitsuba-renderer robin-map f70fd39a960385ef0a963aef00b750e4740228c0 ext/drjit-core/ext/robin_map
GITHUB_SUBMODULES+=	wjakob nanobind v2.14.0 ext/nanobind

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/mitsuba-renderer/drjit
COMMENT=	Just-in-time compiler for differentiable rendering
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-scikit-build-core-[0-9]*:../../devel/py-scikit-build-core
TOOL_DEPENDS+=	${PYPKGPREFIX}-hatch-fancy-pypi-readme-[0-9]*:../../devel/py-hatch-fancy-pypi-readme
# The LLVM backend dlopen()s libLLVM at run time; it is not linked.
DEPENDS+=	llvm>=11:../../lang/llvm

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		cmake

.include "../../mk/bsd.prefs.mk"

# The LLVM backend looks for libLLVM via DRJIT_LIBLLVM_PATH and otherwise
# only in Homebrew/Linux system locations; point the default at pkgsrc's.
SUBST_CLASSES+=		llvm
SUBST_STAGE.llvm=	pre-configure
SUBST_MESSAGE.llvm=	Setting the default libLLVM path.
SUBST_FILES.llvm=	ext/drjit-core/src/llvm_api.cpp
SUBST_VARS.llvm=	LIBLLVM
LIBLLVM=		${PREFIX}/lib/libLLVM.so
.if ${OPSYS} == "Darwin"
LIBLLVM=		${PREFIX}/lib/libLLVM.dylib
.endif

# On Darwin the Metal (Apple GPU) backend is enabled by default in addition
# to the LLVM (CPU) backend; it needs only the SDK frameworks.  CUDA is
# loaded dynamically at run time on other platforms.

# Keep the CMake tree in WRKSRC instead of build/{wheel_tag}.
WHEEL_ARGS+=	-C build-dir=${WRKSRC}/build

.if ${OPSYS} == "Darwin"
# The wrappers drop @loader_path rpaths, so the build-tree extension could
# not find its libraries when nanobind imports it to generate the stubs.
# Use absolute install names instead: build-tree paths while building and
# the final site-packages location after installation.
WHEEL_ARGS+=	-C cmake.define.CMAKE_MACOSX_RPATH=OFF
WHEEL_ARGS+=	-C cmake.define.CMAKE_SKIP_BUILD_RPATH=ON
WHEEL_ARGS+=	-C cmake.define.CMAKE_INSTALL_NAME_DIR=${PREFIX}/${PYSITELIB}/drjit
.endif

# nanobind's own copy of robin-map is a further submodule; reuse the one
# extracted for drjit-core.
post-extract:
	${RMDIR} ${WRKSRC}/ext/nanobind/ext/robin_map 2>/dev/null || ${TRUE}
	${LN} -s ../../drjit-core/ext/robin_map ${WRKSRC}/ext/nanobind/ext/robin_map

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
