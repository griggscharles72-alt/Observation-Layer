#!/usr/bin/env python3
import platform, psutil
from utils.log_writer import write

def run(dry=False, run_id=None):
    if dry:
        payload = {
            "cpu_count": psutil.cpu_count(logical=True),
            "memory_total": psutil.virtual_memory().total,
            "disk_total": psutil.disk_usage("/").total,
            "hostname": platform.node(),
            "platform": platform.system(),
            "dry_run": True
        }
        msg = "[DRY] system scan simulated"
    else:
        mem = psutil.virtual_memory()
        disk = psutil.disk_usage("/")
        payload = {
            "cpu_count": psutil.cpu_count(logical=True),
            "memory_total": mem.total,
            "memory_used": mem.used,
            "disk_total": disk.total,
            "disk_used": disk.used,
            "hostname": platform.node(),
            "platform": platform.system(),
            "dry_run": False
        }
        msg = "system scan executed"
    print(msg)
    write("system", payload, run_id=run_id)
    return payload
