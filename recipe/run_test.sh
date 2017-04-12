#!/usr/bin/env bash
system=$(uname -s)

case $system in
	"Linux" )
        export CC=gcc
		${CC} igraph_test.c $(pkg-config --libs --cflags igraph) -o igraph_test
		./igraph_test
		;;
    "Darwin" )
        export CC=clang
        export CXX=clang++
        export MACOSX_VERSION_MIN="10.7"
        export MACOSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}"
        export CXXFLAGS="${CXXFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
        export CXXFLAGS="${CXXFLAGS} -stdlib=libc++"
        export LDFLAGS="${LDFLAGS} -mmacosx-version-min=${MACOSX_VERSION_MIN}"
        export LDFLAGS="${LDFLAGS} -stdlib=libc++ -lc++"
        export LINKFLAGS="${LDFLAGS}"
        export CFLAGS="${CFLAGS} -m${ARCH}"
        export CXXFLAGS="${CXXFLAGS} -m${ARCH}"
        export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:${PREFIX}/lib
    	${CC} igraph_test.c ${CFLAGS} ${LDFLAGS} $(pkg-config --libs --cflags igraph) -o igraph_test
    	./igraph_test
    	;;
esac
