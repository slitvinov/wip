# $NetBSD$

DISTNAME=	skia_pathops-0.9.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/skia-pathops/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/fonttools/skia-pathops
COMMENT=	Python access to operations on paths using the Skia library
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.2.0:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-packaging-[0-9]*:../../devel/py-packaging
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools_scm-[0-9]*:../../devel/py-setuptools_scm
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
# The sdist bundles the Skia sources; setup.py builds a static libskia
# (path ops only: no GPU, codecs or fonts) with gn and ninja and links
# the extension against it.
TOOL_DEPENDS+=	gn-[0-9]*:../../wip/gn-git
TOOL_DEPENDS+=	ninja-build-[0-9]*:../../devel/ninja-build

USE_LANGUAGES=		c c++
USE_CXX_FEATURES=	c++17

SUBST_CLASSES+=		gn
SUBST_STAGE.gn=		pre-configure
SUBST_MESSAGE.gn=	Setting the path to gn.
SUBST_FILES.gn=		setup.py
SUBST_VARS.gn=		GN
GN=			${PREFIX}/bin/gn


.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
# Skia archives static libraries with Apple's libtool, which must not be
# GNU libtool (from pkgsrc) found first on PATH.
SUBST_CLASSES+=		libtool
SUBST_STAGE.libtool=	pre-configure
SUBST_MESSAGE.libtool=	Using Apple's libtool for static libraries.
SUBST_FILES.libtool=	src/cpp/skia-builder/skia/gn/toolchain/BUILD.gn
SUBST_SED.libtool=	-e 's|command = "libtool -static|command = "/usr/bin/libtool -static|'
.endif

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
