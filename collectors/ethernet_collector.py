#!/usr/bin/env python3
from utils.log_writer import write

def run(dry=False, run_id=None):
    if dry:
        payload = {"interfaces": [], "dry_run": True}
        msg = "[DRY] Ethernet scan simulated"
    else:
        payload = {"interfaces": ["eth0"], "dry_run": False}
        msg = "Ethernet scan executed"
    print(msg)
    write("ethernet", payload, run_id=run_id)
    return payload
