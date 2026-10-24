# $NetBSD$

DISTNAME=	diskcache-5.6.3
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	databases python
MASTER_SITES=	${MASTER_SITE_PYPI:=d/diskcache/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://grantjenks.com/docs/diskcache/
COMMENT=	Disk and file backed persistent cache
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
