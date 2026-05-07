#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-gperdrizet/datascience-nvidia:latest}"
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
check "jupyterlab import"    python3 -c "import jupyterlab"
check "numpy import"         python3 -c "import numpy"
check "pandas import"        python3 -c "import pandas"
check "scipy import"         python3 -c "import scipy"
check "sklearn import"       python3 -c "import sklearn"
check "xgboost import"       python3 -c "import xgboost"
check "statsmodels import"   python3 -c "import statsmodels"
check "matplotlib import"    python3 -c "import matplotlib"
check "seaborn import"       python3 -c "import seaborn"
check "plotly import"        python3 -c "import plotly"
check "optuna import"        python3 -c "import optuna"
check "cupy import"          python3 -c "import cupy"

echo ""
if [ "$FAILS" -eq 0 ]; then
    echo "All tests passed for $IMAGE"
else
    echo "$FAILS test(s) failed for $IMAGE"
    exit 1
fi
