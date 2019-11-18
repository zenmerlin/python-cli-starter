#!/usr/bin/env python3
from configparser import ConfigParser
import os
import subprocess


def main():
    # Retrieve executable name and symlink install path from config.ini
    config = ConfigParser(os.environ)
    config.read("config.ini")
    executable = config["installation"]["executable"]
    executable_path = config["installation"]["executable_path"]

    # Run linux installer script
    subprocess.run(["./installer.sh", executable, executable_path])


if __name__ == "__main__":
    main()