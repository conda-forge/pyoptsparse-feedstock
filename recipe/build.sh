#!/bin/bash

set -eox pipefail

if [[ $CONDA_BUILD_CROSS_COMPILATION == "1" ]]; then
  # Use Meson cross-file flag to enable cross compilation
  setup_args="-Csetup-args=--cross-file=$BUILD_PREFIX/meson_cross_file.txt"
fi

cd "${SRC_DIR}"

$PYTHON -m pip install . "$setup_args"