# $NetBSD$

DISTNAME=	codex-0.164.0
CATEGORIES=	devel
MASTER_SITES=	${MASTER_SITE_GITHUB:=openai/}
GITHUB_TAG=	rust-v${PKGVERSION_NOREV}

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/openai/codex/
COMMENT=	Lightweight coding agent that runs in your terminal
LICENSE=	apache-2.0

# Prebuilt V8 archives are published only for these platforms.
ONLY_FOR_PLATFORM=	Darwin-*-aarch64 Darwin-*-x86_64
ONLY_FOR_PLATFORM+=	Linux-*-aarch64 Linux-*-x86_64

# bindgen (for rama-boring-sys) needs libclang
TOOL_DEPENDS+=	clang-[0-9]*:../../lang/clang
# needed by cmake-sys for rama-boring-sys
TOOL_DEPENDS+=	cmake-[0-9]*:../../devel/cmake

WRKSRC=		${WRKDIR}/codex-rust-v${PKGVERSION_NOREV}
CARGO_WRKSRC=	${WRKSRC}/codex-rs
USE_LANGUAGES=	c c++
USE_TOOLS+=	pkg-config perl gmake

RUST_REQ=	1.99

# codex finds codex-code-mode-host next to itself; GPT models need it.
CARGO_ARGS=	build --release -p codex-cli -p codex-code-mode-host \
		${DEFAULT_CARGO_ARGS}

# Crates from git, not crates.io (user name revision);
# patch-codex-rs_Cargo.toml points at their extracted archives.
GIT_CRATES=	openai-oss-forks crossterm ed1cdab335221515706178d68495bba2aed1924f
GIT_CRATES+=	openai-oss-forks tokio-tungstenite 0e5b2d73aa18dd9f0a50ee9ff199d5aef7594186
GIT_CRATES+=	openai-oss-forks tungstenite-rs 4fffad30fe373adbdcffab9545e9e9bf4f2fc19f
GIT_CRATES+=	hyperium h3 e07e69412876f7e26f026bd75a48b2704d8c8283
GIT_CRATES+=	microsoft mxc b21120168d70befe12356411423266bfef168446
GIT_CRATES+=	helix-editor nucleo 4253de9faabb4e5c6d81d946a5e35a90f87347ee
GIT_CRATES+=	modelcontextprotocol rust-sdk 98a54789b80110ad210495c4ad845c89e1980471
GIT_CRATES+=	dzbarsky rules_rust b56cbaa8465e74127f1ea216f813cd377295ad81

DISTFILES=			${DEFAULT_DISTFILES}
.for user name rev in ${GIT_CRATES}
DISTFILES+=			${name}-${rev}.tar.gz
GIT_CRATE_SITES.${name}=	${MASTER_SITE_GITHUB:=${user}/${name}/archive/${rev}.tar.gz}
SITES.${name}-${rev}.tar.gz=	${GIT_CRATE_SITES.${name}:S,^,-,}
.endfor

# The v8 crate (codex-code-mode-host) wants a prebuilt sandboxed V8;
# codex publishes it.  The build is offline, so fetch it as distfiles.
V8_VERSION=	152.2.0
V8_SITES=	${MASTER_SITE_GITHUB:=openai/codex/releases/download/rusty-v8-v${V8_VERSION}/}
V8_TARGETS=	aarch64-apple-darwin x86_64-apple-darwin
V8_TARGETS+=	aarch64-unknown-linux-gnu x86_64-unknown-linux-gnu

.include "../../mk/bsd.prefs.mk"

.if ${OPSYS} == "Darwin"
V8_TARGET=	${MACHINE_ARCH}-apple-darwin
.else
V8_TARGET=	${MACHINE_ARCH}-unknown-linux-gnu
.endif
V8_ARCHIVE=	librusty_v8_ptrcomp_sandbox_release_${V8_TARGET}.a.gz
V8_BINDING=	src_binding_ptrcomp_sandbox_release_${V8_TARGET}.rs

.for t in ${V8_TARGETS}
.  if ${t} == ${V8_TARGET} || make(distinfo) || make(makesum) || make(mdi)
DISTFILES+=						librusty_v8_ptrcomp_sandbox_release_${t}.a.gz
DISTFILES+=						src_binding_ptrcomp_sandbox_release_${t}.rs
SITES.librusty_v8_ptrcomp_sandbox_release_${t}.a.gz=	${V8_SITES}
SITES.src_binding_ptrcomp_sandbox_release_${t}.rs=	${V8_SITES}
.  endif
.endfor

EXTRACT_ONLY=	${DISTFILES:N*rusty_v8*:N*src_binding*}

MAKE_ENV+=	RUSTY_V8_ARCHIVE=${DISTDIR}/${V8_ARCHIVE}
MAKE_ENV+=	RUSTY_V8_SRC_BINDING_PATH=${DISTDIR}/${V8_BINDING}

INSTALLATION_DIRS=	bin share/doc/codex

do-install:
.for f in codex codex-code-mode-host
	${INSTALL_PROGRAM} ${CARGO_WRKSRC}/target/release/${f} ${DESTDIR}${PREFIX}/bin
.endfor
	${INSTALL_DATA} ${WRKSRC}/README.md ${DESTDIR}${PREFIX}/share/doc/codex

.include "cargo-depends.mk"
.include "../../lang/rust/cargo.mk"
.include "../../security/openssl/buildlink3.mk"
.include "../../mk/bsd.pkg.mk"
