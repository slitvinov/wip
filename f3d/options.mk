# $NetBSD$

PKG_OPTIONS_VAR=	PKG_OPTIONS.f3d
PKG_SUPPORTED_OPTIONS=	python
PKG_SUGGESTED_OPTIONS=	python

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		python

# Python bindings (the "f3d" module).
.if !empty(PKG_OPTIONS:Mpython)
CMAKE_CONFIGURE_ARGS+=	-DF3D_BINDINGS_PYTHON=ON
CMAKE_CONFIGURE_ARGS+=	-Dpybind11_DIR=${BUILDLINK_PREFIX.py-pybind11}/${PYSITELIB}/pybind11/share/cmake/pybind11
CMAKE_CONFIGURE_ARGS+=	-DF3D_BINDINGS_PYTHON_GENERATE_STUBS=OFF
PY_PATCHPLIST=		yes
PLIST.python=		yes
.include "../../lang/python/extension.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DF3D_BINDINGS_PYTHON=OFF
.endif
