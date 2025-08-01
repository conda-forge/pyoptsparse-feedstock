@echo on

cd %SRC_DIR%

REM See the unix build.sh for more details on the build process below.
set MESON_ARGS=-Dpython_target=%PYTHON% %EXTRA_FLAGS%
python -m build -n -x .
pip install --prefix "%PREFIX%" --no-deps --no-index --find-links dist pyoptsparse