@echo on

bash ./bootstrap.sh
bash ./configure
make msvc

cd igraph-%PKG_VERSION%-msvc
copy %LIBRARY_PREFIX%\include\stdint.h winclude

vcbuild /upgrade igraph.vcproj

rem How to pass /DPRPACK_IGRAPH_SUPPORT=1 to build command
vcbuild igraph.vcproj "release|win32"
