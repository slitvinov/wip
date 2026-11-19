# $NetBSD$

DISTNAME=	safetensors-0.7.0
PKGNAME=	${PYPKGPREFIX}-${DISTNAME}
CATEGORIES=	math python
MASTER_SITES=	${MASTER_SITE_PYPI:=s/safetensors/}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://pypi.org/project/safetensors/
COMMENT=	Simple, safe way to store and distribute tensors
LICENSE=	apache-2.0

TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-[0-9]*:../../devel/py-setuptools
TOOL_DEPENDS+=	${PYPKGPREFIX}-setuptools-rust>=1.11.1:../../devel/py-setuptools-rust

DEPENDS+=	${PYPKGPREFIX}-maturin-[0-9]*:../../devel/py-maturin

USE_LANGUAGES=	c

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
