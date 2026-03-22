#!/usr/bin/env python3
from utils.log_writer import write

def run(dry=False, run_id=None):
    if dry:
        payload = {"devices": [], "dry_run": True}
        msg = "[DRY] Bluetooth scan simulated"
    else:
        payload = {"devices": ["Device123"], "dry_run": False}
        msg = "Bluetooth scan executed"
    print(msg)
    write("bluetooth", payload, run_id=run_id)
    return payload
