#!/bin/env bash

set -x -e

export LIBIGRAPH_FALLBACK_INCLUDE_DIRS="${PREFIX}/include"
export LIBIGRAPH_FALLBACK_LIBRARY_DIRS="${PREFIX}/lib"

./configure --prefix=${PREFIX}
make -j $CPU_COUNT
make check
make install
