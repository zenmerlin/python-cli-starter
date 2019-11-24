# Python CLI Starter

Starter project for Python CLI application. This defaults to using Click, but
feel free to substitute with your library of preference. For more information on
using Click to build beautiful CLI applications in Python, see the
[documentation](https://click.palletsprojects.com/en/7.x/).

# Getting Started
## Prerequisites
For installing from source, development, and running builds, the following are
required to be installed:

1. Python 3.6 or greater (tested with 3.7)
2. Pip (tested with 19.3.1)
3. Virtualenv (tested with 16.7.5)

## Installation

### Method 1: Install editable from source

1. Ensure prerequisites are installed.
2. Clone the repo.
3. In the config.ini file, set the name of the main console command you would
   like to use and where to symlink this script to in your path (`$HOME/bin` is
   recommended and is the default):

        [installation]
        executable = <your-preferred-command-name>
        executable_path = %(HOME)s/bin

4. Run the installer:

        python3 install.py

5. Make sure the `executable_path` you set above is in your `PATH` and try
   running the command name you set for `executable`. For example, if you set
   executable to `cmd`, try:

        cmd --help

6. If successful, you should see the base help output of your application.

This method can be used for development and distribution.

Pros: Can edit source more readily.

Cons: More complicated, and requires users to have specific tools installed as
noted in step 1.

### Method 2: Build distributable executable using PyInstaller

1. Ensure prerequisites are installed with the addition of PyInstaller (tested with 3.5):

        pip3 install pyinstaller

2. In the config.ini file, set the name of the main console command you would
   like to use. The `executable_path` is not used in this case, so it is fine to
   leave it as the default:

        [installation]
        executable = <your-preferred-command-name>
        executable_path = %(HOME)s/bin2. Source the included development scripts:

3. Source the dev scripts in your current shell session:

        source dev.sh

3. Run `build`.

...and that's it. This will build a single file executable located in the
`./dist` directory with the name specified in your `config.ini`. Now you can
distribute your application by simply copying the file to the target system and
running it. No install required.

Note: Default build is for linux targets only. TODO: add Windows and MacOS targets.

# Development

For development, after cloning the repo all you need to do to begin working
is create a virtual environment to work in and install the application as
editable. First, you need to set the command name in the config.ini file as in
step 2 above. Then you can create your virtual environment and install the
application into it as follows:

    virtualenv .env
    source .env/bin/activate
    pip install --editable .

You can also use the helper functions in `dev.sh` provided for
convenience. To use these, first `source dev.sh` in your bash/zsh session and
run `initenv` to initialize and activate the environment. At this point your
virtual environment will be activated and you should be able to run the app.
Afterward, you can use `startdev` and `stopdev` to activate and deactivate the
environment respectively. Any changes you make to the code will take affect on
subsequent runs without the need to reinstall.

Other scripts included in `dev.sh`:

    clean: Removes artifacts from prior builds if they exist
    rmenv: Removes virtual environment if it exists
