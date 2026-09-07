@echo on

cd %SRC_DIR%

REM See the unix build.sh for more details on the build process below.

REM flang is built with FLANG_INCLUDE_RUNTIME=OFF, so flang_rt ships separately and its
REM directory is not on the linker search path. With clang-cl, meson links the Fortran
REM extensions by invoking lld-link directly (no compiler driver), so nothing adds that
REM directory. Locate flang_rt and put its directory on LIB so lld-link can find it.
echo === LIB before ===
echo %LIB%
for /f "delims=" %%i in ('where /r "%BUILD_PREFIX%" flang_rt.runtime.dynamic.lib 2^>nul') do set "FLANG_RT_DIR=%%~dpi"
echo FLANG_RT_DIR=%FLANG_RT_DIR%
if defined FLANG_RT_DIR set "LIB=%LIB%;%FLANG_RT_DIR%"
echo === LIB after ===
echo %LIB%

%PYTHON% -m pip install .
