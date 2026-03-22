#!/usr/bin/env python3
"""
Dependency Layer Installer (Python 3.12 compatible)
===================================================

Purpose:
    Install all Python packages needed by the collectors safely.
    - Checks if each package is installed first.
    - Installs only missing packages.
    - Works in .venv or system Python (without breaking system packages).

Usage:
    python3 install_dependencies.py
"""

import subprocess
import sys

# Full list of collector dependencies (Python 3.12 compatible)
REQUIRED_PACKAGES = [
    "psutil",      # system stats
    "scapy",       # packet capture/analysis
    "bleak",       # Bluetooth interactions (replaces pybluez)
    "requests"     # network HTTP utilities
]

# Map pip package names to import names if different
IMPORT_MAPPING = {
    "bleak": "bleak"
}

def install_package(pkg):
    import_name = IMPORT_MAPPING.get(pkg, pkg)
    try:
        __import__(import_name)
        print(f"[OK] {pkg} already installed")
    except ImportError:
        print(f"[INFO] Installing {pkg}...")
        subprocess.run([sys.executable, "-m", "pip", "install", "--upgrade", pkg], check=True)

def main():
    for package in REQUIRED_PACKAGES:
        install_package(package)

if __name__ == "__main__":
    main()
