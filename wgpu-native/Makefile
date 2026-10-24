# $NetBSD$

DISTNAME=		wgpu-native-29.0.1.1
CATEGORIES=		graphics
MASTER_SITES=		${MASTER_SITE_GITHUB:=gfx-rs/}
GITHUB_TAG=		v${PKGVERSION_NOREV}
# The C API headers (webgpu.h) are a git submodule.
GITHUB_SUBMODULES+=	webgpu-native webgpu-headers 673658bc2bd70ec39fc55ebe6bb0173cf6d0a603 ffi/webgpu-headers

MAINTAINER=	pkgsrc-users@NetBSD.org
HOMEPAGE=	https://github.com/gfx-rs/wgpu-native
COMMENT=	Native WebGPU implementation based on wgpu-core
LICENSE=	mit OR apache-2.0

RUST_REQ=	1.87.0

INSTALLATION_DIRS+=	include/webgpu lib share/doc/wgpu-native

# wgpuGetVersion() reports the version compiled in from this variable
# (upstream sets it from the git tag); wgpu-py checks it.
MAKE_ENV+=	WGPU_NATIVE_VERSION=v${PKGVERSION_NOREV}

.include "../../mk/bsd.prefs.mk"

# build.rs runs bindgen, which loads libclang at build time.  On macOS
# clang-sys finds the one of the Command Line Tools or Xcode.
.if ${OPSYS} != "Darwin"
TOOL_DEPENDS+=	clang-[0-9]*:../../lang/clang
MAKE_ENV+=	LIBCLANG_PATH=${PREFIX}/lib
.endif

.if ${OPSYS} == "Darwin"
WGPU_LIB=	libwgpu_native.dylib
.else
WGPU_LIB=	libwgpu_native.so
.endif
PLIST_SUBST+=	WGPU_LIB=${WGPU_LIB}

# The crate builds a cdylib (and a staticlib that is not installed);
# install it and the C headers like the upstream release archives.
do-install:
	${INSTALL_LIB} ${WRKSRC}/target/release/${WGPU_LIB} \
		${DESTDIR}${PREFIX}/lib/${WGPU_LIB}
	${INSTALL_DATA} ${WRKSRC}/ffi/webgpu-headers/webgpu.h \
		${WRKSRC}/ffi/wgpu.h ${DESTDIR}${PREFIX}/include/webgpu
	${INSTALL_DATA} ${WRKSRC}/README.md \
		${DESTDIR}${PREFIX}/share/doc/wgpu-native
.if ${OPSYS} == "Darwin"
	install_name_tool -id ${PREFIX}/lib/${WGPU_LIB} \
		${DESTDIR}${PREFIX}/lib/${WGPU_LIB}
.endif

.include "cargo-depends.mk"
.include "../../lang/rust/cargo.mk"
.include "../../mk/bsd.pkg.mk"
