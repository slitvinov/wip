# $NetBSD$

DISTNAME=	spacy-3.8.18
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/spacy/}

MAINTAINER=	lntl@disroot.org
HOMEPAGE=	https://spacy.io/
COMMENT=	Industrial-strength natural language processing in Python
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-cython>=3.0:../../devel/py-cython
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-catalogue>=2.0.6<2.1.0:../../wip/py-catalogue
DEPENDS+=	${PYPKGPREFIX}-click>=8.2.1:../../devel/py-click
DEPENDS+=	${PYPKGPREFIX}-confection>=1.3.4<2.0.0:../../wip/py-confection
DEPENDS+=	${PYPKGPREFIX}-cymem>=2.0.2<2.1.0:../../wip/py-cymem
DEPENDS+=	${PYPKGPREFIX}-jinja2-[0-9]*:../../textproc/py-jinja2
DEPENDS+=	${PYPKGPREFIX}-murmurhash>=0.28.0<1.1.0:../../wip/py-murmurhash
DEPENDS+=	${PYPKGPREFIX}-packaging>=20.0:../../devel/py-packaging
DEPENDS+=	${PYPKGPREFIX}-preshed>=3.0.15<3.1.0:../../wip/py-preshed
DEPENDS+=	${PYPKGPREFIX}-pydantic>=2.0.0:../../devel/py-pydantic
DEPENDS+=	${PYPKGPREFIX}-requests>=2.13.0:../../devel/py-requests
DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-spacy-legacy>=3.0.11<3.1.0:../../wip/py-spacy-legacy
DEPENDS+=	${PYPKGPREFIX}-spacy-loggers>=1.0.0<2.0.0:../../wip/py-spacy-loggers
DEPENDS+=	${PYPKGPREFIX}-srsly>=2.5.3<3.0.0:../../wip/py-srsly
DEPENDS+=	${PYPKGPREFIX}-thinc>=8.3.12<8.4.0:../../wip/py-thinc
DEPENDS+=	${PYPKGPREFIX}-tqdm>=4.38.0:../../misc/py-tqdm
DEPENDS+=	${PYPKGPREFIX}-typer>=0.3.0:../../devel/py-typer
DEPENDS+=	${PYPKGPREFIX}-wasabi>=0.9.1<1.2.0:../../wip/py-wasabi
DEPENDS+=	${PYPKGPREFIX}-weasel>=1.0.1<2.0.0:../../wip/py-weasel

USE_LANGUAGES=	c c++

PY_RENAME_BINARIES=	spacy

.include "../../math/py-numpy/buildlink3.mk"
.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
