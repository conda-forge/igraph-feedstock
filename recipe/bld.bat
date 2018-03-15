@echo on

bootstrap.sh
configure
make msvc

rem vcbuild /upgrade igraph.vcproj
rem vcbuild igraph.vcproj "release|x64"
