#!/bin/bash
# Display MOTD banner

echo "  ___ _   _ _    _    ___ _____ _   ___ _  __"
echo " | __| | | | |  | |  / __|_   _/_\ / __| |/ /"
echo " | _|| |_| | |__| |__\__ \ | |/ _ \ (__| ' < "
echo " |_|  \___/|____|____|___/ |_/_/ \_\___|_|\_\\"
echo ""
echo "  _____ ___ _  _ ___  ___  ___ ___ _    _____      __"
echo " |_   _| __| \| / __|/ _ \| _ \ __| |  / _ \ \    / /"
echo "   | | | _|| .\` \__ \ (_) |   / _|| |_| (_) \ \/\/ / "
echo "   |_| |___|_|\_|___/\___/|_|_\_| |____\___/ \_/\_/  "
echo ""
echo "─────────────────────────────────────────────────────"
echo ""
echo "  CPU:         $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:      $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:      $(python --version 2>&1 | cut -d' ' -f2)"
echo "  TensorFlow:  $(python -c 'import tensorflow as tf; print(tf.__version__)' 2>/dev/null || echo 'not found')"
echo ""





