#!/bin/bash
# Display MOTD banner

echo ""
cat <<'MOTD'
  _  __   _   ___  ___ _    ___ 
 | |/ /  /_\ / __|/ __| |  | __|
 | ' <  / _ \ (_ | (_ | |__| _| 
 |_|\_\/_/ \_\___|\___|____|___|
MOTD
echo ""
echo "  Kaggle notebook environment mirror — NVIDIA GPU (CUDA 12.8)"
echo "──────────────────────────────────────────────────────────────"
echo ""
echo "  Image:        kaggle-nvidia:$(cat /etc/image-version 2>/dev/null || echo 'unknown')"
echo "  GPU:          $(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | paste -sd ', ' || echo 'not available')"
echo "  CPU:          $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:       $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:       $(python --version 2>&1 | cut -d' ' -f2)"
echo "  PyTorch:      $(pip list 2>/dev/null | grep -E '^torch\s' | awk '{print $2}' || echo 'not found')"
echo "  TensorFlow:   $(pip list 2>/dev/null | grep -E '^tensorflow\s' | awk '{print $2}' || echo 'not found')"
echo "  cuDF:         $(pip list 2>/dev/null | grep -E '^cudf-cu12\s' | awk '{print $2}' || echo 'not found')"
echo "  XGBoost:      $(pip list 2>/dev/null | grep -E '^xgboost\s' | awk '{print $2}' || echo 'not found')"
echo "  Driver:       $(cat /proc/driver/nvidia/version 2>/dev/null | head -1 | awk '{print $8}' || echo 'not available')"
echo ""
