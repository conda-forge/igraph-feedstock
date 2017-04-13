#!/bin/env bash

set -x -e

export LIBIGRAPH_FALLBACK_INCLUDE_DIRS="${PREFIX}/include"
export LIBIGRAPH_FALLBACK_LIBRARY_DIRS="${PREFIX}/lib"

if [ "$(uname)" == "Darwin" ]; then
    CC=${CC} CXX=${CXX} CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} LDFLAGS=${LDFLAGS} ./configure \
        --disable-debug \
        --disable-dependency-tracking \
	    --prefix=${PREFIX}

    make -j $CPU_COUNT
    make install
fi

if [ "$(uname)" == "Linux" ]; then
    ./configure --prefix=${PREFIX}
    make -j $CPU_COUNT
    make check
    make install
fi
