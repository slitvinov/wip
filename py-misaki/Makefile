# $NetBSD$

DISTNAME=	misaki-0.9.4
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc audio python
MASTER_SITES=	${MASTER_SITE_PYPI:=m/misaki/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/hexgrad/misaki
COMMENT=	G2P (grapheme to phoneme) engine for TTS
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-hatchling-[0-9]*:../../devel/py-hatchling
DEPENDS+=	${PYPKGPREFIX}-addict-[0-9]*:../../wip/py-addict
DEPENDS+=	${PYPKGPREFIX}-regex-[0-9]*:../../textproc/py-regex
# "en" extra, without spacy-curated-transformers, which is only needed
# for the transformer-based G2P (trf=True).
DEPENDS+=	${PYPKGPREFIX}-espeakng-loader-[0-9]*:../../wip/py-espeakng-loader
DEPENDS+=	${PYPKGPREFIX}-num2words-[0-9]*:../../wip/py-num2words
DEPENDS+=	${PYPKGPREFIX}-numpy-[0-9]*:../../math/py-numpy
DEPENDS+=	${PYPKGPREFIX}-phonemizer-fork-[0-9]*:../../wip/py-phonemizer-fork
DEPENDS+=	${PYPKGPREFIX}-spacy-[0-9]*:../../wip/py-spacy
# English G2P loads this pipeline and would otherwise run
# "spacy download" (pip) on first use.
DEPENDS+=	${PYPKGPREFIX}-en-core-web-sm-[0-9]*:../../wip/py-en-core-web-sm

USE_LANGUAGES=	# none

.include "../../lang/python/wheel.mk"
.include "../../mk/bsd.pkg.mk"
