@echo on

cd %SRC_DIR%

REM See the unix build.sh for more details on the build process below.

REM Build C/C++ with clang-cl under the vs2022 activation, and Fortran with flang
REM (following conda-forge/scipy-feedstock recipe/bld.bat).
set "CC=clang-cl"
set "CXX=clang-cl"

REM flang 21 ships its runtime as flang_rt.runtime.dynamic.lib in the compiler resource
REM directory, which is not on the linker search path (libflang, which used to place it on
REM LIB, was dropped after flang 20). meson links the Fortran extensions by invoking
REM lld-link directly, so nothing adds that directory. Locate flang_rt and put its
REM directory on LIB so lld-link can find it.
echo === LIB before ===
echo %LIB%
for /f "delims=" %%i in ('where /r "%BUILD_PREFIX%" flang_rt.runtime.dynamic.lib 2^>nul') do set "FLANG_RT_DIR=%%~dpi"
echo FLANG_RT_DIR=%FLANG_RT_DIR%
if defined FLANG_RT_DIR set "LIB=%LIB%;%FLANG_RT_DIR%"
echo === LIB after ===
echo %LIB%

%PYTHON% -m pip install .
