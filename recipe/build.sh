#!/bin/env bash

set -ex
system=$(uname -s)

mkdir -p build
pushd build

cmake -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=$BUILD_PREFIX \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_INSTALL_INCLUDEDIR=include \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    -DCMAKE_POSITION_INDEPENDENT_CODE=on \
    -DIGRAPH_USE_INTERNAL_BLAS=$INTERNAL_BLAS \
    -DIGRAPH_USE_INTERNAL_LAPACK=$INTERNAL_LAPACK \
    -DIGRAPH_USE_INTERNAL_ARPACK=$INTERNAL_ARPACK \
    -DIGRAPH_USE_INTERNAL_GLPK=$INTERNAL_GLPK \
    -DIGRAPH_USE_INTERNAL_CXSPARSE=$INTERNAL_SUITESPARSE \
    -DIGRAPH_USE_INTERNAL_GMP=$INTERNAL_GMP \
    -DBUILD_SHARED_LIBS=on \
    -DIGRAPH_ENABLE_LTO=$ENABLE_LTO \
    -DIGRAPH_ENABLE_TLS=1 \
    -DBUILD_SHARED_LIBS=on \
    ..

cmake --build . --config Release --target igraph
cmake --build . --config Release --target check
cmake --build . --config Release --target install


popd
