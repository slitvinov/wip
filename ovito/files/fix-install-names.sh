#!/bin/sh
# $NetBSD$
#
# Usage: fix-install-names.sh <staged Ovito.app> <final Ovito.app path>
#
# OVITO links its plugins (Contents/PlugIns/*.so) and bundled helper
# libraries (Contents/MacOS/*.dylib) through @rpath.  pkg_add cannot
# resolve @rpath names in REQUIRES, so replace every @rpath reference
# and install name with the absolute path in the installed bundle
# (install_name_tool keeps the ad-hoc linker signatures valid).

set -e
stage=$1
final=$2

machos=$(find "$stage/Contents/MacOS" "$stage/Contents/PlugIns" -type f \
    \( -name '*.so' -o -name '*.dylib' -o -perm -u+x \))

for f in $machos; do
	file "$f" | grep -q Mach-O || continue
	args=
	id=$(otool -D "$f" | sed -n 2p)
	case "$id" in
	@rpath/*)
		args="-id $final/${f#$stage/}"
		;;
	esac
	for dep in $(otool -L "$f" | awk 'NR > 1 { print $1 }'); do
		case "$dep" in
		@rpath/*|"$final"/*)
			name=${dep##*/}
			for d in MacOS PlugIns; do
				if [ -f "$stage/Contents/$d/$name" ]; then
					new="$final/Contents/$d/$name"
					[ "$new" = "$dep" ] || \
					    args="$args -change $dep $new"
					break
				fi
			done
			;;
		esac
	done
	if [ -n "$args" ]; then
		install_name_tool $args "$f"
	fi
done
