# $NetBSD$

DISTNAME=	phonemizer_fork-3.3.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	audio textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=p/phonemizer-fork/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/bootphon/phonemizer
COMMENT=	Simple text to phones converter for multiple languages (fork)
LICENSE=	gnu-gpl-v3

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
DEPENDS+=	${PYPKGPREFIX}-attrs>=18.1:../../devel/py-attrs
DEPENDS+=	${PYPKGPREFIX}-dlinfo-[0-9]*:../../wip/py-dlinfo
DEPENDS+=	${PYPKGPREFIX}-joblib-[0-9]*:../../devel/py-joblib
DEPENDS+=	${PYPKGPREFIX}-segments-[0-9]*:../../wip/py-segments
DEPENDS+=	${PYPKGPREFIX}-typing-extensions-[0-9]*:../../devel/py-typing-extensions
DEPENDS+=	espeak-ng-[0-9]*:../../audio/espeak-ng

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	phonemize

# Find pkgsrc's espeak-ng library when PHONEMIZER_ESPEAK_LIBRARY is unset.
SUBST_CLASSES+=		espeak
SUBST_STAGE.espeak=	pre-configure
SUBST_MESSAGE.espeak=	Setting the path to the espeak-ng library.
SUBST_FILES.espeak=	phonemizer/backend/espeak/wrapper.py
SUBST_SED.espeak=	-e "s|ctypes.util.find_library('espeak-ng')|'${PREFIX}/lib/libespeak-ng.${SHLIB_EXT}'|"

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
