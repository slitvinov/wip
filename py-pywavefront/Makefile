# $NetBSD$

DISTNAME=	PyWavefront-1.3.3
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:tl}
CATEGORIES=	graphics python
# PyPI has only a wheel for 1.3.3, no sdist.
MASTER_SITES=	${MASTER_SITE_GITHUB:=pywavefront/}
GITHUB_PROJECT=	PyWavefront
GITHUB_TAG=	${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/pywavefront/PyWavefront
COMMENT=	Python library for importing Wavefront .obj files
LICENSE=	modified-bsd

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools

USE_LANGUAGES=	# none

WHEEL_NAME=	${DISTNAME:tl}

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
