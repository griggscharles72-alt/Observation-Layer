#!/usr/bin/env python3
from utils.log_writer import write

def run(dry=False, run_id=None):
    if dry:
        payload = {"networks": [], "dry_run": True}
        msg = "[DRY] Wi-Fi scan simulated"
    else:
        payload = {"networks": ["ExampleSSID"], "dry_run": False}
        msg = "Wi-Fi scan executed"
    print(msg)
    write("wifi", payload, run_id=run_id)
    return payload
