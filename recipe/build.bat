@echo on

cd %SRC_DIR%

REM See the unix build.sh for more details on the build process below.

REM Follow scipy's Windows toolchain: the vs2022 compiler activation sets up the MSVC
REM environment (headers, libs, linker, flang runtime search path), C/C++ is compiled with
REM clang-cl, and Fortran with flang. See conda-forge/scipy-feedstock recipe/bld.bat.
set "CC=clang-cl"
set "CXX=clang-cl"

%PYTHON% -m pip install .
