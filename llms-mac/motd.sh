#!/bin/bash
# Display MOTD banner

echo ""
echo "  ___ _   _ _    _    ___ _____ _   ___ _  __"
echo " | __| | | | |  | |  / __|_   _/_\ / __| |/ /"
echo " | _|| |_| | |__| |__\__ \ | |/ _ \ (__| ' < "
echo " |_|  \___/|____|____|___/ |_/_/ \_\___|_|\_\\"
echo ""
cat <<'MOTD'
  _      _   _  _  ___ _   _  _   ___ ___   __  __  ___  ___  ___ _    ___ 
 | |    /_\ | \| |/ __| | | |/_\ / __| __| |  \/  |/ _ \|   \| __| |  / __|
 | |__ / _ \| .` | (_ | |_| / _ \ (_ | _|  | |\/| | (_) | |) | _|| |__\__ \
 |____/_/ \_\_|\_|\___|\___/_/ \_\___|___| |_|  |_|\___/|___/|___|____|___/
MOTD
echo ""
echo "  Apple Silicon (ARM64)"
echo "──────────────────────────────────────────────────────────────────────"
echo ""
echo "  Image:       llms-mac:$(cat /etc/image-version 2>/dev/null || echo 'unknown')"
echo "  Arch:        $(uname -m)"
echo "  Memory:      $(free -h | awk '/^Mem:/ {print $2}') total"
echo "  Python:      $(python --version 2>&1 | cut -d' ' -f2)"
echo "  PyTorch:     $(pip list 2>/dev/null | grep -E '^torch\s' | awk '{print $2}' || echo 'not found')"
echo "  Transformers: $(pip list 2>/dev/null | grep -E '^transformers\s' | awk '{print $2}' || echo 'not found')"
echo "  LangChain:   $(pip list 2>/dev/null | grep -E '^langchain\s' | awk '{print $2}' || echo 'not found')"
echo ""
