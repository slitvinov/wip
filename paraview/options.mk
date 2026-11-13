# $NetBSD$

PKG_OPTIONS_VAR=	PKG_OPTIONS.paraview
PKG_SUPPORTED_OPTIONS=	mpi ospray python qt
PKG_SUGGESTED_OPTIONS=	mpi ospray python qt

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		mpi ospray python qt

# Parallel data processing and rendering (pvserver/pvbatch over MPI).
.if !empty(PKG_OPTIONS:Mmpi)
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_MPI=ON
PLIST.mpi=		yes
.include "../../mk/mpi.buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_MPI=OFF
.endif

# OSPRay ray tracing; VisRTX needs CUDA/OptiX (NVIDIA only).
.if !empty(PKG_OPTIONS:Mospray)
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_RAYTRACING=ON
CMAKE_CONFIGURE_ARGS+=	-DVTK_ENABLE_OSPRAY=ON
PLIST.ospray=		yes
.include "../../wip/ospray/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_ENABLE_RAYTRACING=OFF
CMAKE_CONFIGURE_ARGS+=	-DVTK_ENABLE_OSPRAY=OFF
.endif

# pvpython, pvbatch, the paraview Python package and Python filters.
.if !empty(PKG_OPTIONS:Mpython)
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_PYTHON=ON
# Otherwise FindPython3 may pick another Python (e.g. /usr/bin/python3).
CMAKE_CONFIGURE_ARGS+=	-DPython3_EXECUTABLE=${PYTHONBIN}
DEPENDS+=		${PYPKGPREFIX}-matplotlib-[0-9]*:../../graphics/py-matplotlib
PY_PATCHPLIST=		yes
PLIST.python=		yes
.include "../../lang/python/extension.mk"
.include "../../math/py-numpy/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_PYTHON=OFF
.endif

# The Qt 6 graphical client (paraview).
.if !empty(PKG_OPTIONS:Mqt)
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_QT=ON
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_QT_VERSION=6
PLIST.qt=		yes
.include "../../x11/qt6-qtbase/buildlink3.mk"
.include "../../devel/qt6-qt5compat/buildlink3.mk"
.include "../../devel/qt6-qttools/buildlink3.mk"
.include "../../graphics/qt6-qtsvg/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DPARAVIEW_USE_QT=OFF
.endif
