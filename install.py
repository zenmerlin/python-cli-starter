#!/usr/bin/env python3
from configparser import ConfigParser
import os
import subprocess


def main():
    # Retrieve executable name and symlink install path from config.ini
    config = ConfigParser(os.environ)
    config.read("config.ini")
    try:
        executable = config["installation"]["executable"]
        executable_path = config["installation"]["executable_path"]
    except KeyError as err:
        print(f"Error reading config file\nMissing key: {err}")
        print("Install aborted.")
        exit(1)

    # Run linux installer script
    subprocess.run(["./installer.sh", executable, executable_path])


if __name__ == "__main__":
    main()
