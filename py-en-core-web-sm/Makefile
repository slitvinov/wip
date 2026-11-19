# $NetBSD$

DISTNAME=	en_core_web_sm-3.8.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME:S/_/-/g}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_GITHUB:=explosion/}
GITHUB_PROJECT=	spacy-models
GITHUB_RELEASE=	${DISTNAME}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://spacy.io/models/en
COMMENT=	Small English pipeline for spaCy, optimized for CPU
LICENSE=	mit

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
DEPENDS+=	${PYPKGPREFIX}-spacy>=3.8.0<3.9.0:../../wip/py-spacy

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
