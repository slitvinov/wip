# $NetBSD$

DISTNAME=	box64-0.4.4
CATEGORIES=	emulators
MASTER_SITES=	${MASTER_SITE_GITHUB:=ptitSeb/}
GITHUB_TAG=	v${PKGVERSION_NOREV}

MAINTAINER=	slitvinov@gmail.com
HOMEPAGE=	https://box86.org/
COMMENT=	Linux userspace x86_64 emulator with dynamic recompilation
LICENSE=	mit

# Runs x86_64 Linux ELF binaries on a non-x86 Linux host; the
# dynamic recompiler (dynarec) is enabled where upstream supports it.
ONLY_FOR_PLATFORM=	Linux-*-aarch64 Linux-*-riscv64

USE_LANGUAGES=		c

.include "../../mk/bsd.prefs.mk"

CMAKE_CONFIGURE_ARGS+=	-DCMAKE_BUILD_TYPE=RelWithDebInfo
CMAKE_CONFIGURE_ARGS+=	-DNOGIT=ON
# Do not install prebuilt x86_64 libraries and binaries (box64-bash,
# libstdc++, libssl, ...) into /usr/lib, nor configuration files into
# /etc; the configuration examples are installed below instead.
CMAKE_CONFIGURE_ARGS+=	-DNO_LIB_INSTALL=ON
CMAKE_CONFIGURE_ARGS+=	-DNO_CONF_INSTALL=ON

.if ${MACHINE_ARCH} == "aarch64"
# Generic ARM64 target: ARM dynarec, as used for the RenderMan VM.
CMAKE_CONFIGURE_ARGS+=	-DARM_DYNAREC=ON
.elif ${MACHINE_ARCH} == "riscv64"
CMAKE_CONFIGURE_ARGS+=	-DRV64=ON
.endif

# Read the system-wide rc file from PKG_SYSCONFDIR.
SUBST_CLASSES+=		sysconf
SUBST_STAGE.sysconf=	pre-configure
SUBST_MESSAGE.sysconf=	Fixing path to box64.box64rc.
SUBST_FILES.sysconf=	src/tools/env.c
SUBST_SED.sysconf=	-e 's,"/etc/box64.box64rc","${PKG_SYSCONFDIR}/box64.box64rc",g'

EGDIR=			${PREFIX}/share/examples/box64
CONF_FILES+=		${EGDIR}/box64.box64rc ${PKG_SYSCONFDIR}/box64.box64rc
INSTALLATION_DIRS+=	${EGDIR}

post-build:
	${SED} -e 's,$${CMAKE_INSTALL_PREFIX}/bin/$${BOX64},${PREFIX}/bin/box64,' \
		${WRKSRC}/system/box64.conf.cmake > ${WRKDIR}/box64.conf

post-install:
	${INSTALL_DATA} ${WRKSRC}/system/box64.box64rc ${DESTDIR}${EGDIR}
	${INSTALL_DATA} ${WRKDIR}/box64.conf ${DESTDIR}${EGDIR}

.include "../../devel/cmake/build.mk"
.include "../../lang/python/tool.mk"
.include "../../mk/bsd.pkg.mk"
