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
echo ""echo "  Image:       deeplearning-cpu:$(cat /etc/image-version 2>/dev/null || echo 'unknown')"echo "  CPU:         $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:      $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:      $(python --version 2>&1 | cut -d' ' -f2)"
echo "  TensorFlow:  $(python -c 'import tensorflow as tf; print(tf.__version__)' 2>/dev/null || echo 'not found')"
echo "  PyTorch:     $(python -c 'import torch; print(torch.__version__)' 2>/dev/null || echo 'not found')"
echo ""





