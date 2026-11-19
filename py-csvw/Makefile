# $NetBSD$

DISTNAME=	csvw-4.2.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=c/csvw/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/cldf/csvw
COMMENT=	Python implementation of the W3C CSV on the Web specification
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-babel-[0-9]*:../../devel/py-babel
DEPENDS+=	${PYPKGPREFIX}-dateutil-[0-9]*:../../time/py-dateutil
DEPENDS+=	${PYPKGPREFIX}-isodate-[0-9]*:../../time/py-isodate
DEPENDS+=	${PYPKGPREFIX}-jsonschema-[0-9]*:../../textproc/py-jsonschema
DEPENDS+=	${PYPKGPREFIX}-language-tags-[0-9]*:../../wip/py-language-tags
DEPENDS+=	${PYPKGPREFIX}-rdflib-[0-9]*:../../textproc/py-rdflib
# csvw asks for rfc3986<2, but the URIReference and normalize_uri API
# it uses is unchanged in 2.0.
DEPENDS+=	${PYPKGPREFIX}-rfc3986-[0-9]*:../../www/py-rfc3986
DEPENDS+=	${PYPKGPREFIX}-termcolor-[0-9]*:../../devel/py-termcolor
DEPENDS+=	${PYPKGPREFIX}-uritemplate>=3.0.0:../../textproc/py-uritemplate

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	csvw2datasette csvw2json csvw2markdown csvw2sqlite
PY_RENAME_BINARIES+=	csvwdescribe csvwvalidate

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
