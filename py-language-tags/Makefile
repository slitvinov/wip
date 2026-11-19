# $NetBSD$

DISTNAME=	language_tags-1.3.2
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=l/language-tags/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/OnroerendErfgoed/language-tags
COMMENT=	Work with IANA language tags (BCP 47)
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
TOOL_DEPENDS+=	${PYPKGPREFIX}-hatch-fancy-pypi-readme-[0-9]*:../../devel/py-hatch-fancy-pypi-readme

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
