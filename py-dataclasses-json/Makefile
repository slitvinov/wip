# $NetBSD$

DISTNAME=	dataclasses_json-0.6.7
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=d/dataclasses-json/}

MAINTAINER=	kamelderouiche@yahoo.com
HOMEPAGE=	https://github.com/lidatong/dataclasses-json
COMMENT=	Easily serialize dataclasses to and from JSON
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-poetry-core>=1.2.0:../../devel/py-poetry-core
TOOL_DEPENDS+=	${PYPKGPREFIX}-poetry-dynamic-versioning-[0-9]*:../../devel/py-poetry-dynamic-versioning
DEPENDS+=	${PYPKGPREFIX}-marshmallow>=3.18.0<4:../../wip/py-marshmallow
DEPENDS+=	${PYPKGPREFIX}-typing-inspect>=0.4.0<1:../../devel/py-typing-inspect

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
