#!/bin/sh
# deploy.sh app dest pkg...
# Copy the packages app depends on, and everything they need, from the
# pnpm virtual store into dest/node_modules, keeping the pnpm layout.

die() { echo "deploy.sh: $*" >&2; exit 1; }

app=$1 dest=$2
shift 2
store=`cd "$app/../../node_modules/.pnpm" && pwd -P` || die "no pnpm store"
nm=$dest/node_modules
mkdir -p "$nm/.pnpm" || die "mkdir $nm"

todo=
for p
do
	test -e "$app/node_modules/$p" || continue
	r=`cd "$app/node_modules/$p" && pwd -P`
	r=${r#$store/}
	case $p in
	*/*) mkdir -p "$nm/${p%/*}"; up=../ ;;
	*) up= ;;
	esac
	ln -s "$up.pnpm/$r" "$nm/$p" || die "ln $p"
	todo="$todo ${r%%/*}"
done

while test -n "$todo"
do
	set -- $todo
	todo=
	for x
	do
		test -d "$nm/.pnpm/$x" && continue
		cp -RP "$store/$x" "$nm/.pnpm/$x" || die "cp $x"
		for l in `find "$store/$x/node_modules" -maxdepth 2 -type l ! -path "*/.bin/*"`
		do
			r=`cd "$l" && pwd -P`
			case $r in
			$store/*) r=${r#$store/}; todo="$todo ${r%%/*}" ;;
			esac
		done
	done
done
