#!/bin/bash
# Display MOTD banner

echo ""
echo "  ___   _ _____ _   ___ ___ ____ ___ ___ _  _  ___ ___ "
echo " |   \ /_\_   _/_\ / __/ __/  __|_ _| __| \| |/  _| __|"
echo " | |) / _ \| |/ _ \\__ \__ \ (__ | || _|| .\` | (_| _| "
echo " |___/_/ \_\_/_/ \_\___/___/\___|___|___|_|\_|\___|___|"
echo ""
echo "  CPU only (x86_64)"
echo "───────────────────────────────────────────────────────────"
echo ""
echo "  Image:        datascience-cpu:$(cat /etc/image-version 2>/dev/null || echo 'unknown')"
echo "  CPU:          $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "  Memory:       $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:       $(python --version 2>&1 | cut -d' ' -f2)"
echo "  scikit-learn: $(pip list 2>/dev/null | grep -E '^scikit-learn\s' | awk '{print $2}' || echo 'not found')"
echo "  pandas:       $(pip list 2>/dev/null | grep -E '^pandas\s' | awk '{print $2}' || echo 'not found')"
echo ""
