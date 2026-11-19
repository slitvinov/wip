# $NetBSD$

DISTNAME=	wasabi-1.1.3
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	devel python
MASTER_SITES=	${MASTER_SITE_PYPI:=w/wasabi/}

MAINTAINER=	lntl@disroot.org
HOMEPAGE=	https://github.com/explosion/wasabi
COMMENT=	Lightweight console printing and formatting toolkit
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
