# $NetBSD$

DISTNAME=	segments-2.4.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/segments/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/cldf/segments
COMMENT=	Unicode Standard tokenization routines and orthography profiles
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-csvw>=1.5.6:../../wip/py-csvw
DEPENDS+=	${PYPKGPREFIX}-regex-[0-9]*:../../textproc/py-regex

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	segments

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
