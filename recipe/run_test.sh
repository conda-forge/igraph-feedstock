#!/usr/bin/env bash
set -e
system=$(uname -s)

case $system in
	"Linux" )
        export CC=${CC:-gcc}
		${CC} igraph_test.c $(pkg-config --libs --cflags igraph) -o igraph_test
		./igraph_test
		;;
    "Darwin" )
        export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_FALLBACK_LIBRARY_PATH:${PREFIX}/lib
    	${CC} igraph_test.c ${CFLAGS} ${LDFLAGS} $(pkg-config --libs --cflags igraph) -o igraph_test
    	./igraph_test
    	;;
esac
