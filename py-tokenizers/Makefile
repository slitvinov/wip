# $NetBSD$

DISTNAME=	tokenizers-0.22.1
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	textproc python
MASTER_SITES=	${MASTER_SITE_PYPI:=t/tokenizers/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/huggingface/tokenizers
COMMENT=	Fast state-of-the-art tokenizers for research and production
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-rust>=1.11.1:../../devel/py-setuptools-rust
TOOL_DEPENDS+=	${PYPKGPREFIX}-maturin-[0-9]*:../../devel/py-maturin
DEPENDS+=	${PYPKGPREFIX}-huggingface-hub>=0.16.4:../../wip/py-huggingface-hub

USE_LANGUAGES=	c c++

.include "cargo-depends.mk"

.include "../../mk/bsd.prefs.mk"
.if ${OPSYS} == "Darwin"
# Leave room for cargo.mk to set an absolute install name on the
# extension module.
RUSTFLAGS+=	-C link-arg=-Wl,-headerpad_max_install_names
.endif

.include "../../lang/python/wheel.mk"
.include "../../lang/rust/cargo.mk"
.include "../../mk/bsd.pkg.mk"
