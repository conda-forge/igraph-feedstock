@echo on

bash ./bootstrap.sh
bash ./configure
make msvc

cd igraph-%PKG_VERSION%-msvc
copy %LIBRARY_PREFIX%\include\stdint.h winclude

vcbuild /upgrade igraph.vcproj
vcbuild igraph.vcproj "release|win32"
