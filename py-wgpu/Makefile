# $NetBSD$

DISTNAME=	wgpu-0.32.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=w/wgpu/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/pygfx/wgpu-py
COMMENT=	WebGPU for Python
LICENSE=	2-clause-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
DEPENDS+=	${PYPKGPREFIX}-cffi>=1.15.0:../../devel/py-cffi
DEPENDS+=	${PYPKGPREFIX}-rendercanvas>=2.7:../../wip/py-rendercanvas
# The library is loaded with cffi at import time.
DEPENDS+=	wgpu-native-29.0.1.1{,nb*}:../../wip/wgpu-native

USE_LANGUAGES=	# none

PYTHON_VERSIONS_INCOMPATIBLE=	310 # requires-python >= 3.11

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
# Used to get the CAMetalLayer of a window for presenting.
DEPENDS+=	${PYPKGPREFIX}-rubicon-objc>=0.4.1:../../wip/py-rubicon-objc
.endif

# Built from the sdist, the wheel is pure Python and ships no
# wgpu-native binary (the hatch hook downloads one only in a git
# checkout).  Look for pkgsrc's libwgpu_native in ${PREFIX}/lib rather
# than in sys.exec_prefix, which is the venv in a virtual environment.
# WGPU_LIB_PATH still overrides it.
SUBST_CLASSES+=		libpath
SUBST_STAGE.libpath=	pre-configure
SUBST_MESSAGE.libpath=	Setting the path to libwgpu_native.
SUBST_FILES.libpath=	wgpu/_coreutils.py
SUBST_SED.libpath=	-e 's|Path(sys.exec_prefix) / "lib"|Path("${PREFIX}") / "lib"|'

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
