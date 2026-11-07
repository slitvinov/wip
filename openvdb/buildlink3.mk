# $NetBSD$

BUILDLINK_TREE+=	openvdb

.if !defined(OPENVDB_BUILDLINK3_MK)
OPENVDB_BUILDLINK3_MK:=

BUILDLINK_API_DEPENDS.openvdb+=	openvdb>=7.0.0
BUILDLINK_PKGSRCDIR.openvdb?=	../../wip/openvdb

# The public headers use TBB; the installed FindOpenVDB.cmake also
# requires Blosc and Boost.Iostreams (delayed loading).
.include "../../devel/blosc/buildlink3.mk"
.include "../../devel/boost-headers/buildlink3.mk"
.include "../../devel/boost-libs/buildlink3.mk"
.include "../../parallel/threadingbuildingblocks/buildlink3.mk"
.endif	# OPENVDB_BUILDLINK3_MK

BUILDLINK_TREE+=	-openvdb
