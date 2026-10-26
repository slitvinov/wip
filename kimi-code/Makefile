# $NetBSD$

DISTNAME=	kimi-code-2.3.2
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=MoonshotAI/}
# The release tag (@moonshot-ai/kimi-code@2.3.2) is not a usable path.
GITHUB_TAG=	b8dd3a134060c6e80ba4a1659335cd63b68483f2

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/MoonshotAI/kimi-code/
COMMENT=	Coding agent from Moonshot AI that runs in your terminal
LICENSE=	mit

WRKSRC=		${WRKDIR}/kimi-code-${GITHUB_TAG}
USE_LANGUAGES=	c c++
USE_TOOLS+=	gmake pax tar xz

# package.json: "engines": {"node": ">=24.15.0"}
NODE_VERSIONS_ACCEPTED=	24 26

.include "../../mk/bsd.prefs.mk"

PNPM_VERSION=	10.33.0
PNPM_DIST=	pnpm-${PNPM_VERSION}.tgz
# pnpm content store with every dependency in pnpm-lock.yaml, for the
# platforms below; made by "make PNPM_STORE_UPDATE=yes patch pnpm-store",
# which needs the network.
PNPM_STORE=	${DISTNAME}-pnpm-store.tar.xz

DISTFILES=			${DEFAULT_DISTFILES} ${PNPM_DIST}
PNPM_STORE_UPDATE?=		no
.if ${PNPM_STORE_UPDATE} != yes
DISTFILES+=			${PNPM_STORE}
.endif
SITES.${PNPM_DIST}=		https://registry.npmjs.org/pnpm/-/
EXTRACT_DIR.${PNPM_DIST}=	${WRKDIR}/pnpm

PNPM=		${SETENV} ${MAKE_ENV} ${PREFIX}/bin/node \
		${WRKDIR}/pnpm/package/bin/pnpm.cjs
MAKE_ENV+=	npm_config_store_dir=${WRKDIR}/pnpm-store
MAKE_ENV+=	npm_config_manage_package_manager_versions=false
MAKE_ENV+=	npm_config_update_notifier=false
MAKE_ENV+=	COREPACK_ENABLE_STRICT=0
MAKE_ENV+=	KIMI_DISABLE_TELEMETRY=1

# The runtime dependencies; @mariozechner/clipboard (image paste) is left
# out, it is only published as prebuilt binaries.
DEPLOY_PKGS=	chokidar qrcode ws node-pty
APPDIR=		lib/node_modules/@moonshot-ai/kimi-code
DEPLOY=		${WRKDIR}/deploy
NODE_GYP=	${PREFIX}/lib/node_modules/npm/node_modules/node-gyp/bin/node-gyp.js

INSTALLATION_DIRS=	bin ${APPDIR}

.if ${OPSYS} == "Darwin"
PTY_HELPER=	b/Release/spawn-helper
NATIVE_OS=	darwin
NATIVE_SRC=	darwin-platform.m
NATIVE_OUT=	darwin-platform.node
NATIVE_FLAGS=	-fobjc-arc -std=c11 -Os -fvisibility=hidden -bundle \
		-undefined dynamic_lookup -framework AppKit \
		-framework CoreGraphics -framework Foundation
.else
NATIVE_OS=	linux
NATIVE_SRC=	linux-platform-x11.c
NATIVE_OUT=	linux-platform-x11.node
NATIVE_FLAGS=	-std=c11 -D_POSIX_C_SOURCE=200809L -Os -fPIC -pthread \
		-fvisibility=hidden -shared -Wl,-z,nodelete -lxcb
.endif
.if ${MACHINE_ARCH} == "x86_64"
NATIVE_ARCH=	x64
.else
NATIVE_ARCH=	arm64
.endif
PLIST_SUBST+=	NATIVE_OS=${NATIVE_OS} NATIVE_ARCH=${NATIVE_ARCH}
PLIST_SUBST+=	NATIVE_OUT=${NATIVE_OUT}
NATIVE_DIR=	${WRKSRC}/packages/pi-tui/native/${NATIVE_OS}

# The build scripts call pnpm by name.
pre-configure:
	${RUN}${PRINTF} '#!/bin/sh\nexec ${PREFIX}/bin/node ${WRKDIR}/pnpm/package/bin/pnpm.cjs "$$@"\n' \
		> ${TOOLS_DIR}/bin/pnpm
	${RUN}${CHMOD} +x ${TOOLS_DIR}/bin/pnpm

do-configure:
	${RUN}cd ${WRKSRC} && ${PNPM} install --offline --frozen-lockfile

# Rebuild the bundled native helper from source instead of shipping
# the prebuilt one; drop the helpers for other platforms.
pre-build:
	${RUN}${RM} -rf ${WRKSRC}/packages/pi-tui/native/*/prebuilds
	${RUN}${MKDIR} ${NATIVE_DIR}/prebuilds/${NATIVE_OS}-${NATIVE_ARCH}
	${RUN}cd ${NATIVE_DIR} && ${CC} ${CFLAGS} ${NATIVE_FLAGS} ${LDFLAGS} \
		src/${NATIVE_SRC} \
		-o prebuilds/${NATIVE_OS}-${NATIVE_ARCH}/${NATIVE_OUT}

do-build:
	${RUN}cd ${WRKSRC} && ${PNPM} run build:packages
	${RUN}cd ${WRKSRC} && ${PNPM} -C apps/kimi-code run build
	${RUN}${RM} -rf ${DEPLOY} && ${MKDIR} ${DEPLOY}
	${RUN}cd ${WRKSRC}/apps/kimi-code && \
		${PAX} -rw -pp package.json dist dist-web native ${DEPLOY}
	${RUN}${SH} ${FILESDIR}/deploy.sh ${WRKSRC}/apps/kimi-code ${DEPLOY} \
		${DEPLOY_PKGS}
	${RUN}cd ${DEPLOY}/node_modules/node-pty && ${RM} -rf prebuilds build && \
		${SETENV} ${MAKE_ENV} MAKEFLAGS= MAKE=${GMAKE:Q} \
		${PREFIX}/bin/node ${NODE_GYP} \
		--nodedir=${PREFIX} -j ${MAKE_JOBS:U1} rebuild
	${RUN}cd ${DEPLOY}/node_modules/node-pty && ${MV} build b && \
		${MKDIR} build/Release && \
		${MV} b/Release/pty.node ${PTY_HELPER} build/Release && \
		${RM} -rf b node-addon-api@* third_party

do-install:
	${RUN}cd ${DEPLOY} && ${PAX} -rw -pp . ${DESTDIR}${PREFIX}/${APPDIR}
	${RUN}${LN} -sf ../${APPDIR}/dist/main.mjs ${DESTDIR}${PREFIX}/bin/kimi

SUBST_CLASSES+=		node
SUBST_STAGE.node=	post-build
SUBST_MESSAGE.node=	Fixing path to node.
SUBST_FILES.node=	../deploy/dist/main.mjs
SUBST_SED.node=		-e '1s,^\#!.*,\#!${PREFIX}/bin/node,'

.PHONY: pnpm-store
.if make(pnpm-store)
ALLOW_NETWORK_ACCESS=	yes
.endif
# pnpm fetches only the packages of the host platform; ask for all.
pnpm-store:
	${RUN}${RM} -rf ${WRKDIR}/pnpm-store
	${RUN}${PRINTF} '\nsupportedArchitectures:\n  os: [darwin, linux]\n  cpu: [arm64, x64]\n  libc: [glibc]\n' \
		>> ${WRKSRC}/pnpm-workspace.yaml
	${RUN}cd ${WRKSRC} && ${PNPM} fetch --frozen-lockfile
	${RUN}cd ${WRKDIR} && ${TAR} -cf ${PNPM_STORE:R} pnpm-store && \
		${XZ} -9 -T0 ${PNPM_STORE:R}
	@${ECHO} "Move ${WRKDIR}/${PNPM_STORE} to ${DISTDIR}, then make distinfo."

.include "../../lang/nodejs/nodeversion.mk"
.if ${OPSYS} != "Darwin"
.include "../../x11/libxcb/buildlink3.mk"
.endif
.include "../../mk/bsd.pkg.mk"
