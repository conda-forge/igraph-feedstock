@echo on

mkdir build
if errorlevel 1 exit 1

cd build

cmake %CMAKE_ARGS% -GNinja ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_PREFIX_PATH=%CONDA_PREFIX% ^
      -DCMAKE_INSTALL_LIBDIR=%LIBRARY_LIB% ^
      -DCMAKE_INSTALL_INCLUDEDIR=%LIBRARY_INC% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON ^
      -DIGRAPH_USE_INTERNAL_BLAS=OFF ^
      -DIGRAPH_USE_INTERNAL_LAPACK=OFF ^
      -DIGRAPH_USE_INTERNAL_ARPACK=ON ^
      -DIGRAPH_USE_INTERNAL_GLPK=OFF ^
      -DIGRAPH_USE_INTERNAL_GMP=OFF ^
      -DIGRAPH_USE_INTERNAL_PLFIT=ON ^
      -DIGRAPH_GRAPHML_SUPPORT=ON ^
      -DIGRAPH_GLPK_SUPPORT=ON ^
      -DBUILD_SHARED_LIBS=ON ^
      -DIGRAPH_ENABLE_LTO=ON ^
      -DIGRAPH_ENABLE_TLS=ON ^
      ..
if errorlevel 1 exit 1

cmake --build . --config Release --target igraph -j%CPU_COUNT%
if errorlevel 1 exit 1

cmake --build . --config Release --target build_tests -j%CPU_COUNT%
if errorlevel 1 exit 1

ctest --progress --output-on-failure -C Release --extra-verbose -j%CPU_COUNT%
if errorlevel 1 exit 1
cmake --build . --config Release --target install -j%CPU_COUNT%
if errorlevel 1 exit 1
