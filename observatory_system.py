#!/usr/bin/env python3
"""
Ghost👻Protocol_ElliotCore Observatory System
Portable Phase 1: collectors, logging, CLI
Logs go to ./logs/observatory.jsonl relative to script folder
"""

import os, sys, json, time, socket, subprocess, re
from datetime import datetime, timezone
from pathlib import Path

try:
    import psutil
except ImportError:
    psutil = None

INTERVAL = 10
RUN_ID = None

SCRIPT_DIR = Path(__file__).parent.resolve()
LOG_FILE = SCRIPT_DIR / "logs" / "observatory.jsonl"
CLIP_TEMP = SCRIPT_DIR / "logs" / "sable_clip.txt"
TOOLS_DIR = SCRIPT_DIR / "tools"

# Collectors import
from collectors import system_collector, wifi_collector, bluetooth_collector, ethernet_collector

# Utilities import
from utils import helpers

def now():
    return datetime.now(timezone.utc).isoformat()

def write_log(entry):
    entry["run_id"] = RUN_ID
    try:
        with open(LOG_FILE, "a", encoding="utf-8") as f:
            f.write(json.dumps(entry) + "\n")
    except Exception as e:
        print(f"[LOG ERROR] {e}")

def run_once():
    global RUN_ID
    RUN_ID = str(int(time.time()))
    for collector in [system_collector.collect_system, wifi_collector.collect_wifi,
                      bluetooth_collector.collect_bluetooth, ethernet_collector.collect_ethernet]:
        data = collector()
        if data:
            write_log(data)
            print(f"[ONCE] {data}")

def service_loop():
    global RUN_ID
    RUN_ID = str(int(time.time()))
    print(f"[INFO] Starting session {RUN_ID}")
    try:
        while True:
            run_once()
            time.sleep(INTERVAL)
    except KeyboardInterrupt:
        print("\n[INFO] Service stopped by user")

def launcher():
    if len(sys.argv) < 2:
        print("Usage: run | once | status | help")
        return
    cmd = sys.argv[1].lower()
    if cmd == "run":
        service_loop()
    elif cmd == "once":
        run_once()
    elif cmd == "status":
        print(f"Log file: {LOG_FILE}")
    else:
        print("Usage: run | once | status | help")

if __name__ == "__main__":
    launcher()
