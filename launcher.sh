#!/usr/bin/env bash

BASE="${BASE:-$HOME/ElliotCore_Observatory}"
RUN_ID="${RUN_ID:-$(date +%s)}"

cd "$BASE" || { echo "[ERROR] Cannot enter $BASE"; exit 1; }

# Ensure structure
mkdir -p collectors utils logs tools workers layers

# Ensure python files executable
find collectors utils tools workers layers -type f -name "*.py" -exec chmod +x {} \;

run_collectors() {
python3 -c '
import sys, os

BASE = os.environ.get("BASE")
if BASE not in sys.path:
    sys.path.insert(0, BASE)

from collectors import system_collector, wifi_collector, bluetooth_collector, ethernet_collector

run_id = os.environ.get("RUN_ID", "RUN")

print("[INFO] Running collectors\n")

results = {}
results["system"] = system_collector.run(dry=DRY, run_id=run_id)
results["wifi"] = wifi_collector.run(dry=DRY, run_id=run_id)
results["bluetooth"] = bluetooth_collector.run(dry=DRY, run_id=run_id)
results["ethernet"] = ethernet_collector.run(dry=DRY, run_id=run_id)

print("\n=== RESULTS ===")
for k, v in results.items():
    print(f"{k}: {v}")
'
}

case "$1" in
    dry)
        export DRY=True
        run_collectors
        ;;
    run)
        export DRY=False
        run_collectors
        ;;
    status)
        echo "[INFO] Status:"
        ls -l collectors
        ls -l utils
        ;;
    *)
        echo "Usage: launcher.sh [dry|run|status]"
        ;;
esac
