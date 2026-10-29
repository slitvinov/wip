# $NetBSD$

DISTNAME=	ParaView-v6.2.0
PKGNAME=	${DISTNAME:S/ParaView-v/paraview-/1}
CATEGORIES=	math
PV_VER=		${PKGVERSION_NOREV:C/\.[0-9]+$//}
MASTER_SITES=	https://www.paraview.org/files/v${PV_VER}/
EXTRACT_SUFX=	.tar.xz

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://www.paraview.org/
COMMENT=	VTK-based Data Analysis and Visualization Application
LICENSE=	modified-bsd

USE_PKGLOCALEDIR=	yes
USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17
USE_TOOLS+=		pkg-config

WRKSRC=		${WRKDIR}/${DISTNAME}

.include "../../mk/bsd.prefs.mk"

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=Release
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_BUILD_TESTING=OFF
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_VERSIONED_INSTALL=ON
# Fortran is only used by the Catalyst Fortran adaptor examples.
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_FORTRAN=OFF
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_PYTHON=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_QT=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_QT_VERSION=6
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_QTWEBENGINE=OFF
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_MPI=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_VISKORES=ON
# TBB is the SMP backend of VTK and the host backend of Viskores.
CMAKE_CONFIGURE_ARGS+=	-DVTK_SMP_IMPLEMENTATION_TYPE=TBB
CMAKE_CONFIGURE_ARGS+=	-DVTK_SMP_ENABLE_TBB=ON
CMAKE_CONFIGURE_ARGS+=	-DVTK_SMP_ENABLE_OPENMP=OFF
# OSPRay ray tracing; VisRTX needs CUDA/OptiX (NVIDIA only).
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_RAYTRACING=ON
CMAKE_CONFIGURE_ARGS+=	-DVTK_ENABLE_OSPRAY=ON
CMAKE_CONFIGURE_ARGS+=	-DVTK_ENABLE_VISRTX=OFF
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_FFMPEG=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_XDMF2=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_XDMF3=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_VISITBRIDGE=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_CGNS_READER=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_CGNS_WRITER=ON
# Catalyst needs the separate Kitware catalyst library (not packaged);
# VTK's WebGPU backend needs Dawn (not wgpu-native) and stays off.
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_CATALYST=OFF
# The web (wslink) support needs Python modules that are not packaged.
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_WEB=OFF

# Most third-party code stays bundled (HDF5, NetCDF, CGNS, Exodus and
# IOSS are tightly version-coupled); these are safe to take from pkgsrc.
.for l in expat freetype jpeg libxml2 lz4 lzma png tiff zlib eigen
CMAKE_CONFIGURE_ARGS+=	-DVTK_MODULE_USE_EXTERNAL_VTK_${l}=ON
.endfor

# ffmpeg7 installs its headers and libraries in versioned subdirectories.
PV_FFMPEG_LIBDIR=	${BUILDLINK_DIR}/lib/ffmpeg7
.if ${OPSYS} == "Darwin"
PV_SHLIB_EXT=		.dylib
.else
PV_SHLIB_EXT=		.so
.endif
.for l in avcodec avformat avutil swscale swresample
CMAKE_CONFIGURE_ARGS+=	-DFFMPEG_${l}_INCLUDE_DIR=${BUILDLINK_DIR}/include/ffmpeg7
CMAKE_CONFIGURE_ARGS+=	-DFFMPEG_${l}_LIBRARY=${PV_FFMPEG_LIBDIR}/lib${l}${PV_SHLIB_EXT}
.endfor

DEPENDS+=	${PYPKGPREFIX}-matplotlib-[0-9]*:../../graphics/py-matplotlib

PY_PATCHPLIST=	yes

.if ${OPSYS} == "Darwin"
# Avoid "install_name_tool -delete_rpath" failures on install.
CMAKE_CONFIGURE_ARGS+=	-DCMAKE_SKIP_BUILD_RPATH=ON
LDFLAGS.Darwin+=	-Wl,-headerpad_max_install_names
# The GUI is installed as ${PREFIX}/Applications/paraview.app;
# provide a launcher in bin.
INSTALLATION_DIRS+=	Applications bin

post-install:
	${PRINTF} '#!/bin/sh\nexec "%s" "$$@"\n' \
	    "${PREFIX}/Applications/paraview.app/Contents/MacOS/paraview" \
	    > ${DESTDIR}${PREFIX}/bin/paraview
	${CHMOD} ${BINMODE} ${DESTDIR}${PREFIX}/bin/paraview
.endif

.include "../../devel/cmake/build.mk"

.if ${OPSYS} == "Darwin"
# CMAKE_SKIP_BUILD_RPATH: tools run during the build find libraries here.
MAKE_ENV+=	DYLD_LIBRARY_PATH=${WRKSRC}/${CMAKE_BUILD_DIR}/lib
.else
MAKE_ENV+=	LD_LIBRARY_PATH=${WRKSRC}/${CMAKE_BUILD_DIR}/lib
.endif

PRINT_PLIST_AWK+=	{gsub(/${PV_VER}/, "$${PV_VER}");}

PLIST_SUBST+=	PV_VER=${PV_VER}

.include "../../lang/python/extension.mk"

.include "../../archivers/lz4/buildlink3.mk"
.include "../../archivers/xz/buildlink3.mk"
.include "../../devel/boost-headers/buildlink3.mk"
.include "../../devel/zlib/buildlink3.mk"
.include "../../graphics/freetype2/buildlink3.mk"
.include "../../graphics/png/buildlink3.mk"
.include "../../graphics/tiff/buildlink3.mk"
.include "../../math/eigen3/buildlink3.mk"
.include "../../math/py-numpy/buildlink3.mk"
.include "../../multimedia/ffmpeg7/buildlink3.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.include "../../textproc/expat/buildlink3.mk"
.include "../../textproc/libxml2/buildlink3.mk"
.include "../../wip/ospray/buildlink3.mk"
.if ${OPSYS} != "Darwin"
.include "../../x11/libXaw/buildlink3.mk"
.include "../../x11/libXt/buildlink3.mk"
.endif
.include "../../x11/qt6-qtbase/buildlink3.mk"
.include "../../devel/qt6-qt5compat/buildlink3.mk"
.include "../../devel/qt6-qttools/buildlink3.mk"
.include "../../graphics/qt6-qtsvg/buildlink3.mk"
.include "../../mk/jpeg.buildlink3.mk"
.include "../../mk/mpi.buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
