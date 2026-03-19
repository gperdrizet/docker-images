#!/bin/bash
# Display MOTD banner

echo ""
echo "  ___ _   _ _    _    ___ _____ _   ___ _  __"
echo " | __| | | | |  | |  / __|_   _/_\ / __| |/ /"
echo " | _|| |_| | |__| |__\__ \ | |/ _ \ (__| ' < "
echo " |_|  \___/|____|____|___/ |_/_/ \_\___|_|\_\\"
echo ""
echo "  ___  ___ ___ ___ _    ___   _   ___ _  _ ___ _  _  ___ "
echo " |   \| __| __| _ \ |  | __| /_\ | _ \ \| |_ _| \| |/ __|"
echo " | |) | _|| _||  _/ |__| _| / _ \|   / .\` || || .\` | (_ |"
echo " |___/|___|___|_| |____|___/_/ \_\_|_\_|\_|___|_|\_|\___|"
echo ""
echo "───────────────────────────────────────────────────────────"
echo ""
echo "  GPU:         $(cat /proc/driver/nvidia/gpus/*/information 2>/dev/null | grep 'Model:' | head -1 | cut -d':' -f2 | xargs || echo 'not available')"
echo "  CPU:         $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:      $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:      $(python --version 2>&1 | cut -d' ' -f2)"
echo "  TensorFlow:  $(pip list 2>/dev/null | grep -E '^tensorflow\s' | awk '{print $2}' || echo 'not found')"
echo "  PyTorch:     $(pip list 2>/dev/null | grep -E '^torch\s' | awk '{print $2}' || echo 'not found')"
echo "  CUDA:        $(nvcc --version 2>/dev/null | grep 'release' | sed 's/.*release \([0-9.]*\).*/\1/' || echo 'not available')"
echo "  Driver:      $(cat /proc/driver/nvidia/version 2>/dev/null | head -1 | awk '{print $8}' || echo 'not available')"
echo ""





