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
cp -R "$thisdir/../files" "$tmpdir/etc/pyhole"


