# $NetBSD$

DISTNAME=	manimpango-0.7.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	graphics python
MASTER_SITES=	${MASTER_SITE_PYPI:=m/manimpango/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/ManimCommunity/ManimPango
COMMENT=	Pango bindings for Manim
LICENSE=	mit

# pyproject.toml asks for Cython<3.1; Cython 3.3 builds it fine.
TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.0.2:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-wheel-[0-9]*:../../devel/py-wheel

# setup.py finds pangocairo and pangofc with pkg-config.
USE_TOOLS+=	pkg-config

.include "../../devel/gettext-lib/buildlink3.mk"
.include "../../devel/glib2/buildlink3.mk"
.include "../../devel/pango/buildlink3.mk"
.include "../../fonts/fontconfig/buildlink3.mk"
.include "../../fonts/harfbuzz/buildlink3.mk"
.include "../../graphics/cairo/buildlink3.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
