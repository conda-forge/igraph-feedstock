@echo on
cd msvc

vcbuild /upgrade
vcbuild igraph.vcproj "release|x64"
