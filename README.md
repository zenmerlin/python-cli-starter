# Python CLI Starter

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
2. In the config.ini file, set the name of the main console command you would
   like to use and where to symlink this script in your PATH (`$HOME/bin` is
   the default):

        [installation]
        command = <your-preferred-command-name>
        command_path = %(HOME)s/bin

3. Change to the project root directory and run `./install.py` to create the
   virtual environment, install the app, and link the executable script to
   `command_path`

6. Make sure the `command_path` you set above is in your `PATH` and try
   running the command name you set for `command`. For example, if you set
   command to `cmd`, try:

        cmd --help

7. If successful, you should see the base help output of your application.

Essentially this automates creation of your virtual environment and provides you
with an entry point in your path to run your app without having to
activate/deactivate the virtual environment.

## Development

1. Clone the repo.
2. Modify the command name in config.ini same as you did above.
3. Modify setup.py as needed to add or remove libraries to install.
3. Create virtual environment:

        python3 -m venv .venv

4. Activate the virtual environment.

        . .venv/bin/activate

5. Pip install wheel, followed by your package as editable.

        pip install wheel
        pip install . --editable

6. Install any other tools required for your development environment, such as
   linters such as `pylint`.

7. To exit development environment, run `deactivate` or just exit your shell.
