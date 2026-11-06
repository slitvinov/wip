# $NetBSD$

DISTNAME=	splashsurf-0.14.1
CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_CRATESIO:=splashsurf/}
EXTRACT_SUFX=	.crate

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://splashsurf.physics-simulation.org/
COMMENT=	Surface reconstruction for particle data from SPH simulations
LICENSE=	mit

.include "cargo-depends.mk"

RUST_REQ=	1.88.0

INSTALLATION_DIRS+=	share/doc/splashsurf

post-install:
	${INSTALL_DATA} ${WRKSRC}/README.md ${DESTDIR}${PREFIX}/share/doc/splashsurf

.include "../../lang/rust/cargo.mk"
.include "../../mk/bsd.pkg.mk"
