# $NetBSD$

PKG_OPTIONS_VAR=	PKG_OPTIONS.openusd
PKG_SUPPORTED_OPTIONS=	python
PKG_SUGGESTED_OPTIONS=	python

.include "../../mk/bsd.options.mk"

PLIST_VARS+=		python

# Python bindings (the "pxr" package) and the Python command line tools
# (usdedit, usddiff, usdGenSchema, ...).
.if !empty(PKG_OPTIONS:Mpython)
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_PYTHON_SUPPORT=ON
CMAKE_CONFIGURE_ARGS+=	-DPXR_PYTHON_INSTALL_DIR=${PYSITELIB}
CMAKE_CONFIGURE_ARGS+=	-DPython3_EXECUTABLE=${PYTHONBIN}
DEPENDS+=		${PYPKGPREFIX}-jinja2-[0-9]*:../../textproc/py-jinja2
PY_PATCHPLIST=		yes
REPLACE_PYTHON+=	pxr/usd/bin/*/*.py
REPLACE_PYTHON+=	pxr/usd/usd/usdGenSchema.py
PLIST.python=		yes

# USD installs legacy (non-__pycache__) .pyc files next to the sources.
post-install:
	${FIND} ${DESTDIR}${PREFIX}/${PYSITELIB}/pxr -name '*.pyc' -delete

.include "../../lang/python/application.mk"
.include "../../lang/python/extension.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DPXR_ENABLE_PYTHON_SUPPORT=OFF
.endif
