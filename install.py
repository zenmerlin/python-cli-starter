#!/usr/bin/env python3

"""
Installer script to create virtual environment, install tool and dependencies,
and add command to PATH
"""

from configparser import ConfigParser
import os
import shlex
import shutil
import sys
import subprocess
from subprocess import CalledProcessError


# Python versions below 3.<PY_MINOR_VERSION_MIN> are unsupported
PY_MINOR_VERSION_MIN = 7
UNSUPPORTED_PYTHON = (
    (sys.version_info[0] == 2) or
    (sys.version_info[0] == 3 and sys.version_info[1] < PY_MINOR_VERSION_MIN)
)

# Paths
INSTALL_PATH = os.path.dirname(os.path.abspath(sys.argv[0]))
VENV_PATH = f"{INSTALL_PATH}/.venv"
PIP_PATH = f"{VENV_PATH}/bin/pip"


def create_virtualenv():
    """
    Use the built-in venv to create a virtual environment
    """
    # Check if there's already a virtual environment created and ask user
    # how to proceed if one is found
    if os.path.exists(VENV_PATH):
        print(f"Existing virtual environment detected: {VENV_PATH}")
        choice = input("Proceed with install and overwrite [y/n]? ")
        if choice.upper() != "Y":
            print("Install aborted.")
            sys.exit(0)
        else:
            print("Removing virtual environment...")
            shutil.rmtree(VENV_PATH)

    # Proceed with environment creation and exit if it fails
    print(f"Creating virtual environment {VENV_PATH}...")
    run(f"{sys.executable} -m venv {VENV_PATH}")
    if os.path.exists(VENV_PATH):
        print("Virtual environment created successfully")
    else:
        print("Virtual environment creation failed. Install aborted.")
        sys.exit(1)


def pip_install():
    """
    Install tool and dependencies using pip
    """
    run(f"{PIP_PATH} install wheel")
    run(f"{PIP_PATH} install .")


def read_config(section, key):
    """
    Read in values from config.ini file
    """
    config = ConfigParser(os.environ)
    config.read("config.ini")
    try:
        return config[section][key]
    except KeyError as err:
        exit_on_err(err)


def create_symlink(src, dst):
    """
    Create symlink at dst for executable at src
    """
    # Check if another link already exists
    if os.path.islink(dst):
        print(f"Symlink alread exists at {dst}")
        choice = input("Proceed with install and overwrite [y/n]? ")
        if choice.upper() != "Y":
            print("Install aborted.")
            sys.exit(0)
        else:
            print("Removing symlink...")
            os.remove(dst)

    # Check if there is a file or directory by the same name
    if os.path.exists(dst):
        print(
            f"A file or directory already exists at {dst}"
            "Please backup/remove the existing file or rename your command and"
            "try again."
            "Install aborted."
        )

    # If no conflicts, create the symlink
    print(f"Creating symlink {dst} -> {src}")
    os.symlink(src, dst)


def run(cmd):
    """
    Runs a subprocess and returns its stdout or exits on error
    """
    print(f"Running command: {cmd}")
    try:
        subprocess.run(shlex.split(cmd), check=True)
    except CalledProcessError as err:
        exit_on_err(err)
    except OSError as err:
        exit_on_err(err)


def exit_on_err(err):
    """
    Prints error and exits
    """
    print(f"{err}")
    sys.exit(1)


def main():
    """
    Creates a python virtual environment and installs tool and dependencies

    This will symlink a command entry point to somewhere in your path. Specify
    the name of the command and the path to symlink to in config.ini
    """

    create_virtualenv()
    pip_install()

    # Get the command name and path
    command = read_config("installation", "command")
    command_path = read_config("installation", "command_path")
    # Delete trailing forward slash in case it was entered in config.ini
    if command_path[-1:] == "/":
        command_path = command_path[:-1]

    # Symlink command to path
    src = f"{VENV_PATH}/bin/{command}"
    dst = f"{command_path}/{command}"
    create_symlink(src, dst)

    if os.path.exists(src) and os.path.exists(dst):
        print(f"{command} successfully installed!")
    else:
        print(
            "Hmmm... something went wrong. Missing symlink or entry point."
            "Install failed.")


if __name__ == "__main__":
    if UNSUPPORTED_PYTHON:
        print(
            "Python 3.{} or higher required. Install aborted".format(
                PY_MINOR_VERSION_MIN
            )
        )
        sys.exit(1)
    main()
