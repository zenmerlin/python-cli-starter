# Python CLI Starter

Starter project for Python/Click CLI application. For more information on using
Click to build beautiful CLI applications in Python, see the
[documentation](https://click.palletsprojects.com/en/7.x/).

# Getting Started
## Prerequisites
Ensure the following are installed:

1. Python 3.6 or greater (tested with 3.7)
2. Pip (tested with 19.3.1)
3. Virtualenv (tested with 16.7.5)

## Installation

1. Clone the repo
2. In the config.ini file, set the name of the main console command you would
   like to use and where to symlink this script to in your path (`$HOME/bin` is
   recommended and is the default):

        [installation]
        executable = <your-preferred-command-name>
        executable_path = %(HOME)s/bin

3. Run the installer:

        python3 install.py

4. Make sure the `executable_path` you set above is in your `PATH` and try
   running the command name you set for `executable`. For example, if you set
   executable to `cmd`, try:

        cmd --help

5. If successful, you should see the base help output of your application.

# Development

For development, after cloning the repo you all you need to do to begin working
is create a virtual environment to work in and install the application as
editable. First, you need to set the command name in the config.ini file as in
step 2 above. Then you can create your virtual environment and install the
application into it as follows:

    virtualenv .env
    source .env/bin/activate
    pip install --editable .

There is also a collection of helper functions in `dev.sh` provided for
convenience. To use these, first `source dev.sh` in your bash/zsh session and
run `initdev` to initialize and activate the environment. At this point your
virtual environment will be activated and you should be able to run the app.
Afterward, you can use `startdev` and `stopdev` to activate and deactivate the
environment respectively. Any changes you make to the code will take affect on
subsequent runs without the need to reinstall.
