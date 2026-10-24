# $NetBSD$

DISTNAME=	mitsuba3-3.9.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/mitsuba3/mitsuba/}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_GITHUB:=mitsuba-renderer/}
GITHUB_PROJECT=	mitsuba3
GITHUB_TAG=	v${PKGVERSION_NOREV}

# Git submodules pinned by the v3.9.1 tag that have no pkgsrc equivalent.
# Dr.Jit is linked from wip/py-drjit, but the build still reads its sources
# (version header, cmake-defaults, bin2c.cmake, include paths for the stubs),
# so the same Dr.Jit tree is extracted to ext/drjit.  nanobind and the
# robin-map fork must match the versions wip/py-drjit was built with.
# Mitsuba uses Embree for CPU ray tracing through the Embree 3 API
# (embree3/rtcore.h, symbols in an API namespace); wip/embree is Embree 4,
# whose API differs, so the bundled Embree 3.13 fork is built.  Mitsuba's
# fallback kernel (MI_ENABLE_EMBREE=OFF) misses the Cornell box ceiling
# on this platform, so it is not an alternative.
GITHUB_SUBMODULES+=	mitsuba-renderer embree 97d0e31dae2c69d9706978f5ebfba82a888fd73c ext/embree
# resources/data provides the spectral IOR and sun/sky data files.
GITHUB_SUBMODULES+=	mitsuba-renderer drjit v1.5.0 ext/drjit
GITHUB_SUBMODULES+=	mitsuba-renderer drjit-core 3b96411288b9938889045308654ba37d4ef24b71 ext/drjit/ext/drjit-core
GITHUB_SUBMODULES+=	mitsuba-renderer nanothread a2097209e10852962c485ee46d84d28e7a63a1a1 ext/drjit/ext/drjit-core/ext/nanothread
GITHUB_SUBMODULES+=	mitsuba-renderer cmake-defaults d65442956cd78772ba26ba25dc552de22566b717 ext/drjit/ext/drjit-core/ext/nanothread/ext/cmake-defaults
GITHUB_SUBMODULES+=	wjakob nanobind v2.14.0 ext/nanobind
GITHUB_SUBMODULES+=	mitsuba-renderer robin-map f70fd39a960385ef0a963aef00b750e4740228c0 ext/nanobind/ext/robin_map
GITHUB_SUBMODULES+=	mitsuba-renderer tinyformat 635345c75bd95891ee041ac51ce74ebc891d5bab ext/tinyformat
GITHUB_SUBMODULES+=	mitsuba-renderer rgb2spec f13d570de53544e5008bc8659651503eb05c850e ext/rgb2spec
GITHUB_SUBMODULES+=	mitsuba-renderer struct-jit ea69db6e0b343e69209cedbd84f500eeafe01847 ext/struct-jit
GITHUB_SUBMODULES+=	mitsuba-renderer cmake-defaults 159d5133a67fd22d733645df57cd55a0f9fd13bf ext/struct-jit/ext/cmake-defaults
GITHUB_SUBMODULES+=	mitsuba-renderer mitsuba-data 01100fa9b0b154492061a92404f26dcd7b784dbb resources/data

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.mitsuba-renderer.org/
COMMENT=	Retargetable forward and inverse (differentiable) renderer
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-scikit-build-core-[0-9]*:../../devel/py-scikit-build-core
TOOL_DEPENDS+=	${PYPKGPREFIX}-hatch-fancy-pypi-readme-[0-9]*:../../devel/py-hatch-fancy-pypi-readme

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		cmake

.include "../../mk/bsd.prefs.mk"

WHEEL_ARGS+=	-C cmake.define.MI_DRJIT_CMAKE_DIR=${PREFIX}/${PYSITELIB}/drjit/cmake/drjit
# CMake records the branch/hash of an enclosing git checkout in the
# version string; do not let it find the pkgsrc tree.
MAKE_ENV+=	GIT_CEILING_DIRECTORIES=${WRKDIR}

# Keep the CMake tree in WRKSRC instead of build/{wheel_tag}.
WHEEL_ARGS+=	-C build-dir=${WRKSRC}/build
# Some bundled CMake files declare an old cmake_minimum_required.
WHEEL_ARGS+=	-C cmake.define.CMAKE_POLICY_VERSION_MINIMUM=3.5

# The default variant list (resources/mitsuba.conf.template via
# MI_DEFAULT_VARIANTS) is scalar_rgb, scalar_spectral, llvm_ad_rgb,
# llvm_ad_spectral and, on macOS, metal_ad_rgb (Apple GPU) instead of
# cuda_ad_rgb.  CUDA cannot be used without the NVIDIA toolkit, so drop
# it elsewhere.
.if ${OPSYS} != "Darwin"
WHEEL_ARGS+=	-C cmake.define.MI_DEFAULT_VARIANTS="scalar_rgb,scalar_spectral,llvm_ad_rgb,llvm_ad_spectral"
.endif

.if ${OPSYS} == "Darwin"
# The wrappers drop @loader_path rpaths; use absolute install names (see
# wip/py-drjit).
WHEEL_ARGS+=	-C cmake.define.CMAKE_MACOSX_RPATH=OFF
WHEEL_ARGS+=	-C cmake.define.CMAKE_SKIP_BUILD_RPATH=ON
WHEEL_ARGS+=	-C cmake.define.CMAKE_INSTALL_NAME_DIR=${PREFIX}/${PYSITELIB}/mitsuba
# Embree's old cmake_minimum_required would otherwise let SKIP_BUILD_RPATH
# strip the absolute build-tree install name of libembree3 (CMP0068).
WHEEL_ARGS+=	-C cmake.define.CMAKE_POLICY_DEFAULT_CMP0068=NEW
.endif

# struct-jit takes robin-map from its own nanobind submodule; reuse ours.
post-extract:
	${RMDIR} ${WRKSRC}/ext/struct-jit/ext/nanobind
	${LN} -s ../../nanobind ${WRKSRC}/ext/struct-jit/ext/nanobind

post-install:
	cd ${DESTDIR}${PREFIX}/bin && \
	${MV} mitsuba mitsuba-${PYVERSSUFFIX} || ${TRUE}

.include "../../lang/python/wheel.mk"
.include "../../wip/py-drjit/buildlink3.mk"
.include "../../math/fast_float/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/openexr/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../mk/jpeg.buildlink3.mk"
.include "../../textproc/pugixml/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
