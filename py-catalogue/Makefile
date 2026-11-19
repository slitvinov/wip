# $NetBSD$

DISTNAME=	catalogue-2.0.10
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=c/catalogue/}

MAINTAINER=	kamelderouiche@yahoo.com
HOMEPAGE=	https://github.com/explosion/catalogue
COMMENT=	Super lightweight function registries for your library
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
