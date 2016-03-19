#!/bin/bash

thisdir=$(dirname "$0")
tmpdir=$(mktemp --directory)

mkdir -p "$tmpdir/DEBIAN"
touch "$tmpdir/DEBIAN/.keep"
cp -R "$thisdir/"* "$tmpdir/DEBIAN"

mkdir -p "$tmpdir/usr/bin"
touch "$tmpdir/usr/bin/.keep"
cp -R "$thisdir/../bin/"* "$tmpdir/usr/bin"

mkdir -p "$tmpdir/etc/pyhole"
touch "$tmpdir/etc/pyhole/.keep"

mkdir -p "$tmpdir/usr/share/pyhole"
touch "$tmpdir/usr/share/pyhole/.keep"
cp -R "$thisdir/../files/"* "$tmpdir/usr/share/pyhole"

mkdir -p "$tmpdir/usr/lib/python3.4"
touch "$tmpdir/usr/lib/python3.4/.keep"
cp -R "$thisdir/../lib/pyhole" "$tmpdir/usr/lib/python3.4/pyhole"


mkdir -p "$tmpdir/var/lib/pyhole"
touch "$tmpdir/var/lib/.keep"

dpkg-deb --build "$tmpdir" ~/pyhole.deb

rm -rf "$tmpdir"
