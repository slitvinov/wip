# $NetBSD$

DISTNAME=	taichi-1.7.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	lang python
MASTER_SITES=	${MASTER_SITE_GITHUB:=taichi-dev/}
GITHUB_TAG=	v${PKGVERSION_NOREV}
WRKSRC=		${WRKDIR}/${DISTNAME}

# Git submodules pinned by the v1.7.4 tag that the Metal (gfx/SPIR-V)
# backend and the Python module need.  Eigen comes from math/eigen3.
GITHUB_SUBMODULES+=	KhronosGroup SPIRV-Headers 34d04647d384e0aed037e7a2662a655fc39841bb external/SPIRV-Headers
GITHUB_SUBMODULES+=	KhronosGroup SPIRV-Tools 46ca66e6991f16c89e17ebc9b86995143be2c706 external/SPIRV-Tools
GITHUB_SUBMODULES+=	KhronosGroup SPIRV-Cross c77b09b57c27837dc2d41aa371ed3d236ce9ce47 external/SPIRV-Cross
GITHUB_SUBMODULES+=	KhronosGroup SPIRV-Reflect 7c9c841fa9f40c09d334d5db6629ba318e46efaf external/SPIRV-Reflect
GITHUB_SUBMODULES+=	KhronosGroup Vulkan-Headers 409c16be502e39fe70dd6fe2d9ad4842ef2c9a53 external/Vulkan-Headers
GITHUB_SUBMODULES+=	GPUOpen-LibrariesAndSDKs VulkanMemoryAllocator 539c0a8d8e3733c9f25ea9a184c85c77504f1653 external/VulkanMemoryAllocator
GITHUB_SUBMODULES+=	zeux volk b87f88292b09bc899b24028984186581a1d24c4e external/volk
GITHUB_SUBMODULES+=	gabime spdlog c3aed4b68373955e1cc94307683d44dca1515d2b external/spdlog
GITHUB_SUBMODULES+=	okdshin PicoSHA2 1677374f23352716fc52183255a40c1b8e1d53eb external/PicoSHA2
GITHUB_SUBMODULES+=	Maratyszcza FP16 0a92994d729ff76a58f692d3028ca1b64b145d91 external/FP16
GITHUB_SUBMODULES+=	g-truc glm 06ed280db4e274fa5e1f36d5ea4f7dfd654ff9b0 external/glm
GITHUB_SUBMODULES+=	ocornut imgui c7529c8ea8ef36e344d00cb38e1493b465ce6090 external/imgui
GITHUB_SUBMODULES+=	taichi-dev glfw cf9263d56662ee7fcc18add84d91243167cc0328 external/glfw

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://www.taichi-lang.org/
COMMENT=	Parallel programming language for high-performance computation
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-scikit-build-[0-9]*:../../devel/py-scikit-build
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	ninja-build-[0-9]*:../../devel/ninja-build
DEPENDS+=	${PYPKGPREFIX}-colorama-[0-9]*:../../comms/py-colorama
DEPENDS+=	${PYPKGPREFIX}-dill-[0-9]*:../../textproc/py-dill
DEPENDS+=	${PYPKGPREFIX}-rich-[0-9]*:../../comms/py-rich

# Only the Metal backend (Apple GPU) is built: the LLVM-based CPU and
# CUDA backends need LLVM 15, which pkgsrc does not have.
ONLY_FOR_PLATFORM=	Darwin-*-aarch64

USE_LANGUAGES=		c c++ objc objc-c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		cmake

TAICHI_CMAKE_ARGS=	-DTI_WITH_LLVM=OFF
TAICHI_CMAKE_ARGS+=	-DTI_WITH_METAL=ON
TAICHI_CMAKE_ARGS+=	-DTI_WITH_CUDA=OFF
TAICHI_CMAKE_ARGS+=	-DTI_WITH_VULKAN=OFF
TAICHI_CMAKE_ARGS+=	-DTI_WITH_OPENGL=OFF
TAICHI_CMAKE_ARGS+=	-DTI_WITH_GGUI=OFF
TAICHI_CMAKE_ARGS+=	-DTI_WITH_C_API=OFF
TAICHI_CMAKE_ARGS+=	-DTI_BUILD_TESTS=OFF
TAICHI_CMAKE_ARGS+=	-DTI_BUILD_EXAMPLES=OFF
TAICHI_CMAKE_ARGS+=	-DPYTHON_EXECUTABLE=${PYTHONBIN}
TAICHI_CMAKE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
# Do not install the bundled SPIRV-Tools and SPIRV-Cross (headers,
# libraries, CMake files) into PREFIX; they are linked statically.
TAICHI_CMAKE_ARGS+=	-DSKIP_SPIRV_TOOLS_INSTALL=ON
TAICHI_CMAKE_ARGS+=	-DSPIRV_CROSS_SKIP_INSTALL=ON
# Bundled submodules declare CMake minimum versions that CMake 4 rejects.
TAICHI_CMAKE_ARGS+=	-DCMAKE_POLICY_VERSION_MINIMUM=3.5
MAKE_ENV+=		TAICHI_CMAKE_ARGS=${TAICHI_CMAKE_ARGS:Q}
MAKE_ENV+=		BUILD_NUM_THREADS=${MAKE_JOBS:U1}
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names

# The version banner shows the git commit; the source is not a clone
# (git would report the enclosing pkgsrc repository).
TAICHI_COMMIT=		b4b956fdaa67fd3e198527fd607053ecb9bf4aa2
SUBST_CLASSES+=		commit
SUBST_STAGE.commit=	pre-configure
SUBST_MESSAGE.commit=	Setting the release commit hash.
SUBST_FILES.commit=	CMakeLists.txt
SUBST_SED.commit=	-e 's,COMMAND git rev-parse --short HEAD,COMMAND echo ${TAICHI_COMMIT:C/^(........).*/\1/},'
SUBST_SED.commit+=	-e 's,COMMAND git rev-parse HEAD,COMMAND echo ${TAICHI_COMMIT},'

# Do not turn warnings into errors with newer compilers.
SUBST_CLASSES+=		werror
SUBST_STAGE.werror=	pre-configure
SUBST_MESSAGE.werror=	Removing -Werror.
SUBST_FILES.werror=	cmake/TaichiCXXFlags.cmake
SUBST_SED.werror=	-e 's, -Werror , ,'

# The upstream build driver build.py would shadow the "build" module
# that runs the PEP 517 build.
post-extract:
	${MV} ${WRKSRC}/build.py ${WRKSRC}/build-taichi.py
	${RMDIR} ${WRKSRC}/external/eigen 2>/dev/null || ${TRUE}
	${LN} -s ${BUILDLINK_PREFIX.eigen3}/include/eigen3 ${WRKSRC}/external/eigen

.include "../../lang/python/wheel.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.include "../../math/eigen3/buildlink3.mk"
.include "../../math/py-numpy/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
