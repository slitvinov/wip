# $NetBSD$

DISTNAME=	blender-5.2.2
CATEGORIES=	graphics
MASTER_SITES=	https://download.blender.org/source/
EXTRACT_SUFX=	.tar.xz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.blender.org/
COMMENT=	Fully integrated 3D graphics creation suite
LICENSE=	gnu-gpl-v2

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++20
USE_TOOLS+=		pkg-config
CMAKE_GENERATOR=	ninja

# GCC 11.0.0 or later is required.
GCC_REQD+=	12

.include "../../mk/bsd.prefs.mk"

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DWITH_MEM_JEMALLOC=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_PYTHON_INSTALL=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_PYTHON_INSTALL_NUMPY=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_PYTHON_INSTALL_REQUESTS=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_PYTHON_INSTALL_ZSTANDARD=OFF
CMAKE_CONFIGURE_ARGS+=	-DPYTHON_VERSION=${PYVERSSUFFIX}
CMAKE_CONFIGURE_ARGS+=	-DPYTHON_ROOT_DIR=${PREFIX}
CMAKE_CONFIGURE_ARGS+=	-DWITH_BUILDINFO=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_COMPILER_CCACHE=OFF
# Fail at configure time instead of silently disabling an enabled feature.
CMAKE_CONFIGURE_ARGS+=	-DWITH_STRICT_BUILD_OPTIONS=ON

CMAKE_CONFIGURE_ARGS+=	-DWITH_BULLET=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENCOLORIO=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_FFTW3=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_GMP=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_HARU=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_POTRACE=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_PUGIXML=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_HARFBUZZ=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_FRIBIDI=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_RUBBERBAND=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_IMAGE_OPENJPEG=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_IMAGE_WEBP=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_CODEC_SNDFILE=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_CODEC_FFMPEG=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENAL=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_TBB=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES=ON

# Not available in pkgsrc (yet).
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_OSL=OFF		# OpenShadingLanguage
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_PATH_GUIDING=OFF	# OpenPGL
CMAKE_CONFIGURE_ARGS+=	-DWITH_USD=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_HYDRA=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_MATERIALX=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_XR_OPENXR=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_DRACO=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_MESHOPTIMIZER=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_TRACY=OFF

PLIST_SUBST+=	BLENDERVER=${PKGVERSION_NOREV:R}

# Blender 5.2 requires at least Python 3.13, the version upstream builds with.
PYTHON_VERSIONS_ACCEPTED=	313

# Python modules imported by the bundled scripts (Blender's official
# builds ship them inside the bundle): HTTP downloader for remote asset
# libraries / extensions, and zstd-compressed .blend support.
DEPENDS+=	${PYPKGPREFIX}-cattrs-[0-9]*:../../devel/py-cattrs
DEPENDS+=	${PYPKGPREFIX}-requests-[0-9]*:../../devel/py-requests
DEPENDS+=	${PYPKGPREFIX}-zstandard-[0-9]*:../../archivers/py-zstandard

.if ${OPSYS} == "Darwin"
# platform_apple.cmake normally insists on Blender's pre-compiled
# libraries; patched to use pkgsrc libraries with this switch.
CMAKE_CONFIGURE_ARGS+=	-DWITH_APPLE_SYSTEM_LIBS=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_DEVICE_METAL=ON
.  if ${MACHINE_ARCH} == "aarch64"
CMAKE_CONFIGURE_ARGS+=	-DSSE2NEON_INCLUDE_DIR=${BUILDLINK_DIR}/sse2neon
.  endif
CMAKE_CONFIGURE_ARGS+=	-DWITH_METAL_BACKEND=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_COREAUDIO=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_VULKAN_BACKEND=OFF
# The thumbnailer is a Quick Look app extension that needs code signing.
CMAKE_CONFIGURE_ARGS+=	-DWITH_BLENDER_THUMBNAILER=OFF
# Use OpenAL Soft, not the deprecated OpenAL.framework.
CMAKE_CONFIGURE_ARGS+=	-DOPENAL_INCLUDE_DIR=${BUILDLINK_DIR}/include/AL
CMAKE_CONFIGURE_ARGS+=	-DOPENAL_LIBRARY=${BUILDLINK_DIR}/lib/libopenal.dylib
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
# Ceres is no longer bundled and not in pkgsrc.
CMAKE_CONFIGURE_ARGS+=	-DWITH_LIBMV=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_MANIFOLD=OFF
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_INSTALL_PORTABLE=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_SDL_DYNLOAD=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_SYSTEM_EIGEN=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_SYSTEM_FREETYPE=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_LIBMV=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_MANIFOLD=OFF
# uses alloca() but sets -std=c++17
FORCE_CXX_STD=		gnu++20
.endif

# ffmpeg8 lives in versioned subdirectories.
BLENDER_FFMPEG_LIBDIR=	${BUILDLINK_DIR}/lib/ffmpeg8
.if ${OPSYS} == "Darwin"
BLENDER_FFMPEG_SOEXT=	.dylib
.else
BLENDER_FFMPEG_SOEXT=	.so
.endif
.for l in avcodec avdevice avfilter avformat avutil swscale swresample
CMAKE_CONFIGURE_ARGS+=	-DFFMPEG_${l:tu}_LIBRARY=${BLENDER_FFMPEG_LIBDIR}/lib${l}${BLENDER_FFMPEG_SOEXT}
.endfor
CMAKE_CONFIGURE_ARGS+=	-D_ffmpeg_INCLUDE_DIR=${BUILDLINK_DIR}/include/ffmpeg8

REPLACE_PYTHON+=	scripts/modules/blend_render_info.py

.if ${OPSYS} == "Darwin"
# CMake installs the application bundle into ${PREFIX}/Blender.app;
# move it to ${PREFIX}/Applications and provide a launcher in bin.
INSTALLATION_DIRS+=	Applications bin
SUBST_CLASSES+=		launcher
SUBST_STAGE.launcher=	pre-configure
SUBST_FILES.launcher=	${WRKDIR}/blender.sh
SUBST_VARS.launcher=	PREFIX

pre-configure: blender-launcher
.PHONY: blender-launcher
blender-launcher:
	${CP} ${FILESDIR}/blender.sh ${WRKDIR}/blender.sh
.  if ${MACHINE_ARCH} == "aarch64"
# Cycles builds its CPU kernels with -Werror=double-promotion; pkgsrc's
# newer sse2neon.h trips it unless it is included as a system header,
# which only works if it is not also reachable through a plain -I path.
	${MKDIR} ${BUILDLINK_DIR}/sse2neon
	${MV} ${BUILDLINK_DIR}/include/sse2neon.h ${BUILDLINK_DIR}/sse2neon/
.  endif

post-install:
	${RM} -rf ${DESTDIR}${PREFIX}/Applications/Blender.app
	${MV} ${DESTDIR}${PREFIX}/Blender.app ${DESTDIR}${PREFIX}/Applications/
	${INSTALL_SCRIPT} ${WRKDIR}/blender.sh ${DESTDIR}${PREFIX}/bin/blender
.endif

.include "options.mk"
.include "../../archivers/zstd/buildlink3.mk"
.include "../../audio/openal-soft/buildlink3.mk"
.include "../../audio/libsndfile/buildlink3.mk"
.include "../../audio/rubberband/buildlink3.mk"
.include "../../devel/cmake/build.mk"
.include "../../devel/gettext-tools/buildlink3.mk"
.include "../../devel/gmp/buildlink3.mk"
.include "../../devel/pystring/buildlink3.mk"
.if ${OPSYS} == "Darwin" && ${MACHINE_ARCH} == "aarch64"
.include "../../devel/sse2neon/buildlink3.mk"
.endif
BUILDLINK_API_DEPENDS.freetype2+=	freetype2>=2.13.0
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../graphics/hicolor-icon-theme/buildlink3.mk"
.include "../../graphics/libepoxy/buildlink3.mk"
.include "../../graphics/libwebp/buildlink3.mk"
.include "../../graphics/opencolorio/buildlink3.mk"
.include "../../graphics/openexr/buildlink3.mk"
.include "../../graphics/openimageio/buildlink3.mk"
.include "../../graphics/openjpeg/buildlink3.mk"
.include "../../graphics/potrace/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../graphics/tiff/buildlink3.mk"
.include "../../graphics/libjpeg-turbo/buildlink3.mk"
.include "../../math/eigen3/buildlink3.mk"
.include "../../math/fftw/buildlink3.mk"
.include "../../math/imath/buildlink3.mk"
.include "../../math/py-numpy/buildlink3.mk"
.include "../../multimedia/ffmpeg8/buildlink3.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../print/libharu/buildlink3.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../textproc/fmtlib/buildlink3.mk"
.include "../../converters/fribidi/buildlink3.mk"
.include "../../fonts/harfbuzz/buildlink3.mk"
.include "../../textproc/pugixml/buildlink3.mk"
.include "../../textproc/yaml-cpp/buildlink3.mk"
.if ${OPSYS} != "Darwin"
.include "../../devel/libexecinfo/buildlink3.mk"
.include "../../graphics/glew/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
.include "../../graphics/shaderc/buildlink3.mk"
.include "../../graphics/vulkan-loader/buildlink3.mk"
.include "../../sysutils/desktop-file-utils/desktopdb.mk"
.endif
.include "../../lang/python/application.mk"
.include "../../mk/bsd.pkg.mk"
