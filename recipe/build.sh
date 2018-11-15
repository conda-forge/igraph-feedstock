#!/bin/env bash

set -x -e

export LIBIGRAPH_FALLBACK_INCLUDE_DIRS="${PREFIX}/include"
export LIBIGRAPH_FALLBACK_LIBRARY_DIRS="${PREFIX}/lib"

if [ "$(uname)" == "Linux" ]
then
   export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

./configure --prefix=${PREFIX}
make -j $CPU_COUNT
make check || (cat tests/testsuite.log && exit 1)
make install
mv igraph.pc ${PREFIX}/lib/pkgconfig
