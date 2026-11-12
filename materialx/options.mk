# $NetBSD$

PKG_OPTIONS_VAR=	PKG_OPTIONS.materialx
PKG_SUPPORTED_OPTIONS=	python
PKG_SUGGESTED_OPTIONS=	python

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		python

# Python bindings (the "MaterialX" module) and the example scripts in
# share/MaterialX/scripts.
.if !empty(PKG_OPTIONS:Mpython)
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_PYTHON=ON
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_PYTHON_EXECUTABLE=${PYTHONBIN}
# Do not run pip at install time; install the Python package directly.
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_INSTALL_PYTHON=OFF
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_PYTHON_FOLDER_NAME=${PYSITELIB}/MaterialX
PY_PATCHPLIST=		yes
REPLACE_PYTHON+=	python/Scripts/*.py
INSTALLATION_DIRS+=	share/MaterialX/scripts
PLIST.python=		yes
.include "../../lang/python/application.mk"
.include "../../lang/python/extension.mk"
.include "../../devel/py-pybind11/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DMATERIALX_BUILD_PYTHON=OFF
.endif
