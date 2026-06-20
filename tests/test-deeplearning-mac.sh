#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-gperdrizet/deeplearning-mac:latest}"
FAILS=0

check() {
    local desc="$1"; shift
    if docker run --rm --platform linux/arm64 "$IMAGE" "$@" > /dev/null 2>&1; then
        echo "  PASS: $desc"
    else
        echo "  FAIL: $desc"
        ((FAILS++)) || true
    fi
}

echo "==> Testing $IMAGE"

check "ARM64 architecture"   uname -m
check "Python 3.12"          python3 -c "import sys; assert sys.version_info[:2] == (3, 12), sys.version"
check "torch import"         python3 -c "import torch"
check "torch CPU only"       python3 -c "import torch; assert not torch.cuda.is_available(), 'CUDA unexpectedly available'"
check "tensorflow import"    python3 -c "import tensorflow"
check "jupyterlab import"    python3 -c "import jupyterlab"
check "keras_tuner import"   python3 -c "import keras_tuner"
check "optuna import"        python3 -c "import optuna"
check "matplotlib import"    python3 -c "import matplotlib"
check "seaborn import"       python3 -c "import seaborn"

echo ""
if [ "$FAILS" -eq 0 ]; then
    echo "All tests passed for $IMAGE"
else
    echo "$FAILS test(s) failed for $IMAGE"
    exit 1
fi
