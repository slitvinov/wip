# $NetBSD: options.mk,v 1.9 2015/04/13 23:22:03 othyro Exp $

PKG_OPTIONS_VAR=	PKG_OPTIONS.opensubdiv
PKG_SUPPORTED_OPTIONS=	opengl ptex # cuda tbb opencl dx11
PKG_SUGGESTED_OPTIONS=	opengl
PLIST_VARS+=		opengl # ptex has no extra PLIST entries

.include 		"../../mk/bsd.options.mk"
.include "../../mk/bsd.prefs.mk"

.if !empty(PKG_OPTIONS:Mopengl)
.  if ${OPSYS} != "Darwin"
# Darwin uses the native OpenGL framework.
.include "../../graphics/glew/buildlink3.mk"
.include "../../graphics/glu/buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=	-DGLEW_LOCATION:PATH=${BUILDLINK_PREFIX.glew}
CMAKE_CONFIGURE_ARGS+=	-DNO_GLEW:BOOL=OFF
.  endif
PLIST.opengl=	yes
.else
CMAKE_CONFIGURE_ARGS+=	-DNO_OPENGL:BOOL=ON
.endif

.if !empty(PKG_OPTIONS:Mptex)
.include "../../graphics/ptex/buildlink3.mk"
CMAKE_CONFIGURE_ARGS+=	-DPTEX_LOCATION:PATH=${BUILDLINK_PREFIX.ptex}
.else
CMAKE_CONFIGURE_ARGS+=	-DNO_PTEX:BOOL=ON
.endif

# The documentation (doxygen and rst2html) is not built; its files were
# never listed in the PLIST.
CMAKE_CONFIGURE_ARGS+=	-DNO_DOC:BOOL=ON
