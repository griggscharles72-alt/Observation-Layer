#!/usr/bin/env bash
# ElliotCore_Observatory universal launcher
# Fully portable, relative paths, single entry for once/run/status

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3}"
OBS_SCRIPT="$SCRIPT_DIR/observatory_system.py"

# Ensure the Python script exists and is executable
if [[ ! -f "$OBS_SCRIPT" ]]; then
    echo "[ERROR] observatory_system.py not found in $SCRIPT_DIR"
    exit 1
fi
chmod +x "$OBS_SCRIPT"

# Default command
CMD="${1:-help}"

case "$CMD" in
    run)
        echo "[INFO] Starting continuous service..."
        "$OBS_SCRIPT" run
        ;;
    once)
        echo "[INFO] Running single snapshot..."
        "$OBS_SCRIPT" once
        ;;
    status)
        echo "[INFO] Showing config/status..."
        "$OBS_SCRIPT" status
        ;;
    help|*)
        echo "Usage: $0 {run|once|status|help}"
        ;;
#!/usr/bin/env bash
# ElliotCore_Observatory universal launcher
# Fully portable, relative paths, single entry for once/run/status

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3}"
OBS_SCRIPT="$SCRIPT_DIR/observatory_system.py"

# Ensure the Python script exists and is executable
if [[ ! -f "$OBS_SCRIPT" ]]; then
    echo "[ERROR] observatory_system.py not found in $SCRIPT_DIR"
    exit 1
fi
chmod +x "$OBS_SCRIPT"

# Default command
CMD="${1:-help}"

case "$CMD" in
    run)
        echo "[INFO] Starting continuous service..."
        "$OBS_SCRIPT" run
        ;;
    once)
        echo "[INFO] Running single snapshot..."
        "$OBS_SCRIPT" once
        ;;
    status)
        echo "[INFO] Showing config/status..."
        "$OBS_SCRIPT" status
        ;;
    help|*)
        echo "Usage: $0 {run|once|status|help}"
        ;;
esac        "$OBS_SCRIPT" status
        ;;
    help|*)
        echo "Usage: $0 {run|once|status|help}"
        ;;
esac
