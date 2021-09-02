# {{ cookiecutter.project_name }} 
# TODO: Replace with relevant content for your app

Starter project for Python CLI application. This defaults to using Click, but
feel free to substitute with your library of preference. For more information on
using Click to build CLI applications in Python, see the
[documentation](https://click.palletsprojects.com/en/7.x/).

# Getting Started
## Prerequisites
Make sure you have Python 3.6 or greater (tested with 3.7) installed. The
install script uses the built in venv and pip modules for the install, so you
shouldn't need to install anything else explicitly.

## Installation

1. Clone the repo.

2. Change to the project root directory and run `./install.py` to create the
   virtual environment and install the app,

3. If successful, you should be able to run the command as follows:

        {{ cookiecutter.command }} --help

4. If successful, you should see the base help output of your application.

## Docker Build

Basic Dockerfile included to build an image of your app. To use, run:

    docker build -t {{ cookiecutter.project_name }}:latest .

You can then run the app with:

    docker run {{ cookiecutter.project_name }}:latest {{ cookiecutter.command }} --help

## Development

For development, create a python virtual environment named something other than the
the default from the install (something like .denv):

    python3 -m venv .denv

Then activate the environment (make sure all subsequent commands are run in the
shell with the activated development environment) and install prerequisite
dependencies:

    . ./.denv/bin/activate
    pip install --upgrade pip setuptools wheel

Next install the app and it's dependencies using the `--editable/-e` flag so
your code changes will be picked up when run:

    pip install -e .

