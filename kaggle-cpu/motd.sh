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
echo "  Kaggle notebook environment mirror, CPU only (x86_64)"
echo "───────────────────────────────────────────────────────────"
echo ""
echo "  Image:        kaggle-cpu:$(cat /etc/image-version 2>/dev/null || echo 'unknown')"
echo "  CPU:          $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:       $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:       $(python --version 2>&1 | cut -d' ' -f2)"
echo "  PyTorch:      $(pip list 2>/dev/null | grep -E '^torch\s' | awk '{print $2}' || echo 'not found')"
echo "  TensorFlow:   $(pip list 2>/dev/null | grep -E '^tensorflow\s' | awk '{print $2}' || echo 'not found')"
echo "  scikit-learn: $(pip list 2>/dev/null | grep -E '^scikit-learn\s' | awk '{print $2}' || echo 'not found')"
echo "  XGBoost:      $(pip list 2>/dev/null | grep -E '^xgboost\s' | awk '{print $2}' || echo 'not found')"
echo ""
