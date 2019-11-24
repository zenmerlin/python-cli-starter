"""Parser to get config values from ini files"""
from configparser import ConfigParser
import os
import sys


def main(section, key):
    config = ConfigParser(os.environ)
    config.read("config.ini")
    try:
        print(config[section][key])
    except KeyError as err:
        print(f"Error reading config file\nMissing key: {err}")
        exit(1)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
