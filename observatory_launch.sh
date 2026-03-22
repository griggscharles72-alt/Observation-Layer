#!/usr/bin/env bash
set -euo pipefail

echo "[V2 LAUNCH] Starting full observatory setup..."

# Ensure logs folder exists
mkdir -p "$HOME/ElliotCore_Observatory/logs"

# Dependencies (assume venv already active)
pip install --upgrade pip >/dev/null 2>&1 || true
python3 -c "import psutil" >/dev/null 2>&1 && echo "[OK] psutil already installed"
python3 -c "import scapy" >/dev/null 2>&1 && echo "[OK] scapy already installed"
python3 -c "import bleak" >/dev/null 2>&1 && echo "[OK] bleak already installed"
python3 -c "import requests" >/dev/null 2>&1 && echo "[OK] requests already installed"

# Folder structure check
for dir in tools collectors logs utils workers layers/dependencies; do
    [[ -d "$HOME/ElliotCore_Observatory/$dir" ]] && echo "[OK] $dir exists" || echo "[MISSING] $dir"
done

# Generate unique RUN_ID
export RUN_ID=${RUN_ID:-$(date +%s)}

# --------------------------
# 4. Run collectors (fixed)
# --------------------------
for mod in system_collector wifi_collector bluetooth_collector ethernet_collector; do
    echo "[INFO] Running collector: $mod"
    python3 - <<PYTHON
import sys, os
sys.path.insert(0, "$HOME/ElliotCore_Observatory")
from utils import log_writer

RUN_ID = os.environ.get("RUN_ID")
mod = "$mod"

try:
    c = __import__("collectors." + mod, fromlist=[""])
    if hasattr(c, "run"):
        c.run(dry=True, run_id=RUN_ID)
        print(f"[OK] {mod} executed")
    else:
        print(f"[WARN] {mod} missing run()")
except Exception as e:
    print(f"[ERROR] {mod} ->", e)
PYTHON
done

# --------------------------
# 5. Summary
# --------------------------
LOG_FILE="$HOME/ElliotCore_Observatory/logs/observatory.jsonl"
echo "[SUMMARY] Last 10 log entries:"
[[ -f "$LOG_FILE" ]] && tail -n 10 "$LOG_FILE" || echo "[WARN] No log file found at $LOG_FILE"
