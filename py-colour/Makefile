# $NetBSD$

DISTNAME=	colour-0.1.5
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=c/colour/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/vaab/colour
COMMENT=	Converts and manipulates common color representations
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	# none

# setup.cfg holds d2to1 metadata that newer setuptools reject.
post-extract:
	${RM} -f ${WRKSRC}/setup.cfg

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
