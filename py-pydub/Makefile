# $NetBSD$

DISTNAME=	pydub-0.25.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	audio python
MASTER_SITES=	${MASTER_SITE_PYPI:=p/pydub/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://pydub.com/
COMMENT=	Manipulate audio with a simple and easy high level interface
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
# pydub decodes and encodes everything but WAV through ffmpeg/ffprobe.
DEPENDS+=	ffmpeg7-[0-9]*:../../multimedia/ffmpeg7

USE_LANGUAGES=	# none

.include "../../lang/python/pyversion.mk"
# audioop was removed from the standard library in Python 3.13.
.if ${PYTHON_VERSION} >= 313
DEPENDS+=	${PYPKGPREFIX}-audioop-lts-[0-9]*:../../audio/py-audioop-lts
.endif

# pkgsrc installs ffmpeg7 with a version suffix; use it when PATH has none.
SUBST_CLASSES+=		ffmpeg
SUBST_STAGE.ffmpeg=	pre-configure
SUBST_MESSAGE.ffmpeg=	Setting the path to pkgsrc's ffmpeg7.
SUBST_FILES.ffmpeg=	pydub/utils.py
SUBST_VARS.ffmpeg=	FFMPEG FFPROBE
FFMPEG=			${PREFIX}/bin/ffmpeg7
FFPROBE=		${PREFIX}/bin/ffprobe7

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
