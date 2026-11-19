# $NetBSD$

DISTNAME=	thinc-8.3.14
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_PYPI:=t/thinc/}

MAINTAINER=	lntl@disroot.org
HOMEPAGE=	https://github.com/explosion/thinc
COMMENT=	Functional take on deep learning, used by spaCy
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.0:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-blis>=1.3.0<1.4.0:../../wip/py-blis
DEPENDS+=	${PYPKGPREFIX}-catalogue>=2.0.4<2.1.0:../../wip/py-catalogue
DEPENDS+=	${PYPKGPREFIX}-confection>=1.1.0<2.0.0:../../wip/py-confection
DEPENDS+=	${PYPKGPREFIX}-cymem>=2.0.2<2.1.0:../../wip/py-cymem
DEPENDS+=	${PYPKGPREFIX}-murmurhash>=1.0.2<1.1.0:../../wip/py-murmurhash
DEPENDS+=	${PYPKGPREFIX}-packaging>=20.0:../../devel/py-packaging
DEPENDS+=	${PYPKGPREFIX}-preshed>=3.0.2<3.1.0:../../wip/py-preshed
DEPENDS+=	${PYPKGPREFIX}-pydantic>=2.0.0:../../devel/py-pydantic
DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-srsly>=2.4.0<3.1.0:../../wip/py-srsly
DEPENDS+=	${PYPKGPREFIX}-wasabi>=0.8.1<1.2.0:../../wip/py-wasabi

USE_LANGUAGES=	c c++

.include "../../math/py-numpy/buildlink3.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
