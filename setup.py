from configparser import ConfigParser
import os
from setuptools import setup, find_packages

# Get name of console command from config
config = ConfigParser(os.environ)
config.read("config.ini")
command = config["installation"]["command"]


setup(
    name="mycli",
    version="0.0.1",
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        "Click==7.0",
    ],
    entry_points= f"""
        [console_scripts]
        {command}=mycli.cli:cli
    """
)

