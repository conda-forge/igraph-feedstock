#!/bin/env bash

set -x -e

export LIBIGRAPH_FALLBACK_INCLUDE_DIRS="${PREFIX}/include"
export LIBIGRAPH_FALLBACK_LIBRARY_DIRS="${PREFIX}/lib"

export CFLAGS="-I$PREFIX/include $CFLAGS"
export CXXFLAGS="-I$PREFIX/include $CXXFLAGS"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib $LDFLAGS"

./bootstrap.sh
./configure --prefix=${PREFIX}
make -j $CPU_COUNT
make check || (cat tests/testsuite.log && exit 1)
make install
mv igraph.pc ${PREFIX}/lib/pkgconfig
