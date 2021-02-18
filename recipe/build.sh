#!/bin/env bash

set -ex

mkdir -p build
pushd build

cmake -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_INSTALL_INCLUDEDIR=include \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_C_FLAGS="$CFLAGS" \
      -DCMAKE_POSITION_INDEPENDENT_CODE=on \
      -DBLA_VENDOR=OpenBLAS \
      -DBUILD_SHARED_LIBS=on \
      ..

cmake --build . --config Release --target igraph
cmake --build . --config Release --target check
cmake --build . --config Release --target install


popd
