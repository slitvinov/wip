# $NetBSD$

DISTNAME=	ezdxf-1.4.5
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	cad python
MASTER_SITES=	${MASTER_SITE_PYPI:=e/ezdxf/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://ezdxf.mozman.at/
COMMENT=	Python package to create and modify DXF drawings
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel
# Cython builds the optional ezdxf.acc C extensions (vector math,
# Bezier and B-spline evaluation, earcut); without it setup.py silently
# falls back to the slower pure-Python code.
TOOL_DEPENDS+=	${PYPKGPREFIX}-cython-[0-9]*:../../devel/py-cython
DEPENDS+=	${PYPKGPREFIX}-fonttools-[0-9]*:../../fonts/py-fonttools
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-pyparsing>=3.0.0:../../devel/py-pyparsing
DEPENDS+=	${PYPKGPREFIX}-typing-extensions>=4.6.0:../../devel/py-typing-extensions

USE_LANGUAGES=	c

.include "../../lang/python/application.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
