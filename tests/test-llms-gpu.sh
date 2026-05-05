#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-gperdrizet/llms-gpu:latest}"
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

check "Python 3.12"                 python3 -c "import sys; assert sys.version_info[:2] == (3, 12), sys.version"
check "torch import"                python3 -c "import torch"
check "torch CUDA available"        python3 -c "import torch; assert torch.cuda.is_available(), 'CUDA not available'"
check "langchain import"            python3 -c "import langchain"
check "langchain_community import"  python3 -c "import langchain_community"
check "transformers import"         python3 -c "import transformers"
check "smolagents import"           python3 -c "import smolagents"
check "chromadb import"             python3 -c "import chromadb"
check "sentence_transformers import" python3 -c "import sentence_transformers"
check "gradio import"               python3 -c "import gradio"
check "datasets import"             python3 -c "import datasets"
check "bitsandbytes import"         python3 -c "import bitsandbytes"
check "ollama binary"               which ollama

echo ""
if [ "$FAILS" -eq 0 ]; then
    echo "All tests passed for $IMAGE"
else
    echo "$FAILS test(s) failed for $IMAGE"
    exit 1
fi
