from configparser import ConfigParser
import os
from setuptools import setup, find_packages

# Get name of executable console command from config
config = ConfigParser(os.environ)
config.read("config.ini")
executable = config["installation"]["executable"]


setup(
    name="python-cli-starter",
    version="0.0.1",
    py_modules=["cli"],
    install_requires=[
        "Click==7.0",
    ],
    entry_points= {
        "console_scripts": [
            f"{executable}=cli:cli"
        ]
    }
)
