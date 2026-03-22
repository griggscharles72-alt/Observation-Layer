#!/usr/bin/env python3
import json, os
BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOG_FILE = os.path.join(BASE, "logs", "observatory.jsonl")
os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)

def write(source, payload, run_id=None):
    entry = {"source": source, "payload": payload, "run_id": run_id}
    print(f"[DUMMY WRITE] {source}: {payload}")
    try:
        with open(LOG_FILE, "a", encoding="utf-8") as f:
            f.write(json.dumps(entry) + "\n")
    except Exception as e:
        print(f"[LOG ERROR] {e}")
