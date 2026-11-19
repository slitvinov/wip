# $NetBSD$

DISTNAME=	weasel-1.0.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=w/weasel/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/explosion/weasel
COMMENT=	Small and easy workflow system
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-click>=8.0.0:../../devel/py-click
DEPENDS+=	${PYPKGPREFIX}-cloudpathlib>=0.7.0:../../wip/py-cloudpathlib
DEPENDS+=	${PYPKGPREFIX}-confection>=1.3.4<2.0.0:../../wip/py-confection
DEPENDS+=	${PYPKGPREFIX}-httpx>=0.24.0:../../www/py-httpx
DEPENDS+=	${PYPKGPREFIX}-packaging>=20.0:../../devel/py-packaging
DEPENDS+=	${PYPKGPREFIX}-pydantic>=2.0.0:../../devel/py-pydantic
DEPENDS+=	${PYPKGPREFIX}-smart-open>=5.2.1:../../wip/py-smart-open
DEPENDS+=	${PYPKGPREFIX}-srsly>=2.4.3:../../wip/py-srsly
DEPENDS+=	${PYPKGPREFIX}-typer>=0.3.0:../../devel/py-typer
DEPENDS+=	${PYPKGPREFIX}-wasabi>=0.9.1:../../wip/py-wasabi

USE_LANGUAGES=	# none

PY_RENAME_BINARIES=	weasel

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
