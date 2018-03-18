:: Configure
call "%VCINSTALLDIR%\bin\vcvars32.bat"

set CONF=Release
if "%ARCH%" == "64" (
  set ARCH=x64
) else (
  set ARCH=x86
)

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
copy Release\igraph.lib %LIBRARY_LIB% || exit 1
xcopy /S /I include %LIBRARY_INC%\igraph || exit 1
