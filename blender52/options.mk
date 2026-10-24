# $NetBSD$

PKG_OPTIONS_VAR=		PKG_OPTIONS.blender52
PKG_SUPPORTED_OPTIONS=		alembic embree jack oidn opensubdiv openvdb
PKG_SUGGESTED_OPTIONS=		alembic embree oidn opensubdiv openvdb

.include "../../mk/bsd.fast.prefs.mk"

.if ${OPSYS} != "Darwin"
PKG_SUPPORTED_OPTIONS+=		pulseaudio
.endif

.include "../../mk/bsd.options.mk"

# Alembic import/export.
.if !empty(PKG_OPTIONS:Malembic)
CMAKE_CONFIGURE_ARGS+=	-DWITH_ALEMBIC=ON
.include "../../wip/alembic/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_ALEMBIC=OFF
.endif

# Embree ray tracing kernels for Cycles CPU rendering.
.if !empty(PKG_OPTIONS:Membree)
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_EMBREE=ON
.include "../../wip/embree/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_CYCLES_EMBREE=OFF
.endif

.if !empty(PKG_OPTIONS:Mjack)
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK_DYNLOAD=OFF
.include "../../audio/jack/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_JACK=OFF
.endif

# Intel Open Image Denoise (CPU; Metal device needs the Metal compiler).
.if !empty(PKG_OPTIONS:Moidn)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENIMAGEDENOISE=ON
.include "../../wip/oidn/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENIMAGEDENOISE=OFF
.endif

.if !empty(PKG_OPTIONS:Mopensubdiv)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENSUBDIV=ON
.include "../../wip/opensubdiv/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENSUBDIV=OFF
.endif

# OpenVDB volumes; NanoVDB (shipped with OpenVDB) for GPU volume rendering.
.if !empty(PKG_OPTIONS:Mopenvdb)
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENVDB=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_NANOVDB=ON
.include "../../wip/openvdb/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_OPENVDB=OFF
CMAKE_CONFIGURE_ARGS+=	-DWITH_NANOVDB=OFF
.endif

.if !empty(PKG_OPTIONS:Mpulseaudio)
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO=ON
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO_DYNLOAD=OFF
.include "../../audio/pulseaudio/buildlink3.mk"
.else
CMAKE_CONFIGURE_ARGS+=	-DWITH_PULSEAUDIO=OFF
.endif
