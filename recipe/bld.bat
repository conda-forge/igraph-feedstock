:: Configure
set CONF=Release
if "%ARCH%" == "64" (
  set ARCH=x64
) else (
  set ARCH=Win32
)

call "%VCINSTALLDIR%\bin\vcvars32.bat"

cd igraph-%PKG_VERSION%-msvc
rem copy %LIBRARY_PREFIX%\include\stdint.h winclude

call devenv igraph.sln /Upgrade

:: Build
call msbuild igraph.sln ^
  /t:Build /v:minimal ^
  /p:Configuration=%CONF% ^
  /p:Platform=%ARCH%

if errorlevel 1 exit 1

:: Install
copy Release\libigraph.lib %LIBRARY_BIN% || exit 1
copy include %LIBRARY_INCLUDE%\igraph || exit 1
