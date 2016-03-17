#!/bin/bash

thisdir=$("$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )")
tmpdir=$(mktemp --directory)

mkdir -p "$tmpdir/DEBIAN"
cp -R "$thisdir" "$tmpdir/DEBIAN"

mkdir -p "$tmpdir/usr/bin"
cp -R "$thisdir/../bin/*" "$tmpdir/usr/bin"

mkdir -p "$tmpdir/etc/pyhole"
cp -R "$thisdir/../files" "$tmpdir/etc/pyhole"


