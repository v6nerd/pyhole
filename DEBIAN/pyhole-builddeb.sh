#!/bin/bash

thisdir=$(dirname "$0")
tmpdir=$(mktemp --directory)

# /DEBIAN
mkdir -p "$tmpdir/DEBIAN"
touch "$tmpdir/DEBIAN/.keep"
cp -R "$thisdir/"* "$tmpdir/DEBIAN"

# /usr/bin
mkdir -p "$tmpdir/usr/bin"
cp -R "$thisdir/../bin/"* "$tmpdir/usr/bin"

# /etc & /etc/pyhole
mkdir -p "$tmpdir/etc/pyhole"
touch "$tmpdir/etc/pyhole/.keep"
cp -R "$thisdir/../etc/"* "$tmpdir/etc"

# /usr/share/pyhole
mkdir -p "$tmpdir/usr/share/pyhole"
touch "$tmpdir/usr/share/pyhole/.keep"
cp -R "$thisdir/../files/"* "$tmpdir/usr/share/pyhole"

# /usr/lib/python3.4/pyhole
mkdir -p "$tmpdir/usr/lib/python3.4/pyhole"
touch "$tmpdir/usr/lib/python3.4/pyhole/.keep"
cp -R "$thisdir/../lib/pyhole/"* "$tmpdir/usr/lib/python3.4/pyhole"

# /var/lib/pyhole
mkdir -p "$tmpdir/var/lib/pyhole"
touch "$tmpdir/var/lib/.keep"

dpkg-deb --build "$tmpdir" "$thisdir/pyhole.deb"

rm -rf "$tmpdir"
