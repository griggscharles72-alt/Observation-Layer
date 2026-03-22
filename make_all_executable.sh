#!/usr/bin/env bash
# Make all Python files and key scripts in ElliotCore_Observatory executable

BASE="${BASE:-$HOME/ElliotCore_Observatory}"
cd "$BASE" || { echo "[ERROR] Cannot enter $BASE"; exit 1; }

echo "[INFO] Making all Python files executable in main repo folders..."
mkdir -p collectors utils tools workers layers

for DIR in collectors utils tools workers layers; do
    if [[ -d "$BASE/$DIR" ]]; then
        find "$BASE/$DIR" -type f -name "*.py" -exec chmod +x {} \;
        echo "[OK] All Python files in $DIR are now executable."
    else
        echo "[MISSING] $DIR folder does not exist, skipping."
    fi
done

# Optional: make launchers executable if present
for SCRIPT in run_collectors_dry.sh launcher.sh; do
    if [[ -f "$BASE/$SCRIPT" ]]; then
        chmod +x "$BASE/$SCRIPT"
        echo "[OK] $SCRIPT is now executable."
    fi
done

echo "[INFO] Listing collector and utils files with permissions:"
ls -l collectors utils
echo "[INFO] All permissions set."
