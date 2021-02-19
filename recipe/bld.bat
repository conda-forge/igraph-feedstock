@echo on

mkdir build
if errorlevel 1 exit 1

cd build

cmake -GNinja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH=%CONDA_PREFIX% ^
      -DCMAKE_INSTALL_LIBDIR=%LIBRARY_LIB% ^
      -DCMAKE_INSTALL_INCLUDEDIR=%LIBRARY_INC% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_POSITION_INDEPENDENT_CODE=on ^
      -DIGRAPH_USE_INTERNAL_BLAS=0 ^
      -DIGRAPH_USE_INTERNAL_LAPACK=0 ^
      -DIGRAPH_USE_INTERNAL_ARPACK=1 ^
      -DIGRAPH_USE_INTERNAL_GLPK=0 ^
      -DIGRAPH_USE_INTERNAL_CXSPARSE=0 ^
      -DIGRAPH_USE_INTERNAL_GMP=1 ^
      -DBUILD_SHARED_LIBS=on ^
      -DIGRAPH_ENABLE_LTO=1 ^
      -DIGRAPH_ENABLE_TLS=1 ^
      -DIGRAPH_GRAPHML_SUPPORT=1 ^
      ..

cmake --build . --config Release --target igraph
cmake --build . --config Release --target build_tests
ctest --progress --output-on-failure --config C Release
if errorlevel 1 exit 1
cmake --build . --config Release --target install

if errorlevel 1 exit 1
