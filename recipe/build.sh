#!/bin/env bash

set -ex
system=$(uname -s)

mkdir -p build
pushd build

case $system in
    "Linux" )
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
        ;;
    "Darwin" )
        cmake -GNinja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_PREFIX_PATH=$PREFIX \
            -DCMAKE_INSTALL_LIBDIR=lib \
            -DCMAKE_INSTALL_INCLUDEDIR=include \
            -DCMAKE_INSTALL_PREFIX=$PREFIX \
            -DCMAKE_C_FLAGS="$CFLAGS" \
            -DLIBXML2_LIBRARY=$PREFIX/lib/libxml2.dylib \
            -DLIBXML2_INCLUDE_DIR=$PREFIX/include/libxml2/ \
            -DCMAKE_POSITION_INDEPENDENT_CODE=on \
            -DBLA_VENDOR=OpenBLAS \
            -DBUILD_SHARED_LIBS=on \
            ..
        ;;
esac

cmake --build . --config Release --target igraph
cmake --build . --config Release --target check
cmake --build . --config Release --target install


popd
