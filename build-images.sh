#!/bin/sh
SRC=`readlink -e $0`
SRCDIR=`dirname "$SRC"`

set -e

# TODO: Build base images with docker's mkimage.sh

docker build -t linux-portable-x86_64 "$SRCDIR"/docker

sed -e "s/:6-x86_64/:6-i386/" \
    -e "s/libc6-dev-i386/libc6-dev-amd64/" \
    -e "s/Architecture.X86_64/Architecture.X86/" \
    -e "s/x86_64-linux-gnu/i686-linux-gnu/" \
    -e "s/appimagetool-x86_64/appimagetool-i686/" \
    "$SRCDIR"/docker/Dockerfile > "$SRCDIR"/docker/Dockerfile.i686
docker build -t linux-portable-i686 -f "$SRCDIR"/docker/Dockerfile.i686 "$SRCDIR"/docker

