#!/bin/bash

set -eox pipefail

if [[ $CONDA_BUILD_CROSS_COMPILATION == "1" ]]; then
  # Use Meson cross-file flag to enable cross compilation
  EXTRA_FLAGS="--cross-file $BUILD_PREFIX/meson_cross_file.txt"
fi

cd "${SRC_DIR}"

$PYTHON -m build -n -x .
pip install --prefix "${PREFIX}" --no-deps --no-index --find-links dist pyoptsparse
