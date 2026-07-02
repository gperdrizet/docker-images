#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-gperdrizet/kaggle-mac:latest}"
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

# Exact version asserts — matching Kaggle's environment is the point of this image
check "numpy 2.0.2"          python3 -c "import numpy; assert numpy.__version__ == '2.0.2', numpy.__version__"
check "pandas 2.3.3"         python3 -c "import pandas; assert pandas.__version__ == '2.3.3', pandas.__version__"
check "sklearn 1.6.1"        python3 -c "import sklearn; assert sklearn.__version__ == '1.6.1', sklearn.__version__"
check "xgboost 3.2.0"        python3 -c "import xgboost; assert xgboost.__version__ == '3.2.0', xgboost.__version__"
check "torch 2.10.0"         python3 -c "import torch; assert torch.__version__.startswith('2.10.0'), torch.__version__"
check "tensorflow 2.20.0"    python3 -c "import tensorflow; assert tensorflow.__version__ == '2.20.0', tensorflow.__version__"

# Import checks
check "jupyterlab import"    python3 -c "import jupyterlab"
check "lightgbm import"      python3 -c "import lightgbm"
check "catboost import"      python3 -c "import catboost"
check "polars import"        python3 -c "import polars"
check "transformers import"  python3 -c "import transformers"
check "cv2 import"           python3 -c "import cv2"
check "matplotlib import"    python3 -c "import matplotlib"
check "seaborn import"       python3 -c "import seaborn"
check "optuna import"        python3 -c "import optuna"
check "kaggle CLI"           kaggle --version
check "kagglehub import"     python3 -c "import kagglehub"

echo ""
if [ "$FAILS" -eq 0 ]; then
    echo "All tests passed for $IMAGE"
else
    echo "$FAILS test(s) failed for $IMAGE"
    exit 1
fi
