#!/bin/env bash

set -x -e

export LIBIGRAPH_FALLBACK_INCLUDE_DIRS="${PREFIX}/include"
export LIBIGRAPH_FALLBACK_LIBRARY_DIRS="${PREFIX}/lib"

# Fix conflict with libc++ version file
rm VERSION
# fix the simple test runner which doesn't use ldflags
export CC="${CC} ${CFLAGS} ${LDFLAGS}"

./configure --prefix=${PREFIX}
make -j $CPU_COUNT | sed "s|$PREFIX|<PREFIX>|g"
(make check | sed "s|$PREFIX|<PREFIX>|g") || (cat tests/testsuite.log && exit 1)
make install
mv igraph.pc ${PREFIX}/lib/pkgconfig
