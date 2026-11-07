# $NetBSD$

BUILDLINK_TREE+=	wgpu-native

.if !defined(WGPU_NATIVE_BUILDLINK3_MK)
WGPU_NATIVE_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.wgpu-native+=	wgpu-native>=29.0.1.1
BUILDLINK_PKGSRCDIR.wgpu-native?=	../../wip/wgpu-native
.endif	# WGPU_NATIVE_BUILDLINK3_MK

BUILDLINK_TREE+=	-wgpu-native
