#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-gperdrizet/kaggle-nvidia:latest}"
FAILS=0

check() {
    local desc="$1"; shift
    if docker run --rm --gpus all "$IMAGE" "$@" > /dev/null 2>&1; then
        echo "  PASS: $desc"
    else
        echo "  FAIL: $desc"
        ((FAILS++)) || true
    fi
}

echo "==> Testing $IMAGE"

check "Python 3.12"          python3 -c "import sys; assert sys.version_info[:2] == (3, 12), sys.version"

# Exact version asserts — matching Kaggle's environment is the point of this image
check "numpy 2.0.2"          python3 -c "import numpy; assert numpy.__version__ == '2.0.2', numpy.__version__"
check "pandas 2.3.3"         python3 -c "import pandas; assert pandas.__version__ == '2.3.3', pandas.__version__"
check "sklearn 1.6.1"        python3 -c "import sklearn; assert sklearn.__version__ == '1.6.1', sklearn.__version__"
check "xgboost 3.2.0"        python3 -c "import xgboost; assert xgboost.__version__ == '3.2.0', xgboost.__version__"
check "torch 2.10.0"         python3 -c "import torch; assert torch.__version__.startswith('2.10.0'), torch.__version__"
check "tensorflow 2.20.0"    python3 -c "import tensorflow; assert tensorflow.__version__ == '2.20.0', tensorflow.__version__"

# GPU checks — custom torch wheel supports sm_60+, so real kernel ops work on the
# P100 CI runner (unlike Kaggle's stock wheel).
check "torch CUDA available" python3 -c "import torch; assert torch.cuda.is_available(), 'CUDA not available'"
check "torch GPU kernel op"  python3 -c "import torch; x = torch.ones(1000, device='cuda') * 2; assert x.sum().item() == 2000.0"

# RAPIDS — import-only: cudf/cuml/cupy kernels require sm_70+ (Volta or newer),
# which the P100 (sm_60) CI runner cannot execute. Same limitation exists on
# Kaggle's own P100 sessions.
check "cudf import"          python3 -c "import cudf"
check "cuml import"          python3 -c "import cuml"
check "cupy import"          python3 -c "import cupy"

# TensorFlow GPU — soft check (device visibility only). Stock TF 2.20 Pascal
# support is unverified; do not require kernel execution.
check "tensorflow GPU visible" python3 -c "import tensorflow as tf; assert len(tf.config.list_physical_devices('GPU')) > 0"

# Import checks
check "jupyterlab import"    python3 -c "import jupyterlab"
check "lightgbm import"      python3 -c "import lightgbm"
check "catboost import"      python3 -c "import catboost"
check "polars import"        python3 -c "import polars"
check "transformers import"  python3 -c "import transformers"
check "cv2 import"           python3 -c "import cv2"
check "matplotlib import"    python3 -c "import matplotlib"
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
