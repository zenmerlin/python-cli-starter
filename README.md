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
   like to use and where to symlink this script in your path (`$HOME/bin` is
   recommended and is the default):

        [installation]
        executable = <your-preferred-command-name>
        executable_path = %(HOME)s/bin

4. Change to the project root directory and source the dev scripts into your 
   current shell session:

        source dev.sh

5. Run `installsrc` to create the virtual environment, install the app, and 
   link the executable script to `executable_path`

6. Make sure the `executable_path` you set above is in your `PATH` and try
   running the command name you set for `executable`. For example, if you set
   executable to `cmd`, try:

        cmd --help

7. If successful, you should see the base help output of your application.

This method can be used for development and distribution. Essentially this
automates creation of your virtual environment and provides you with an 
entry point in your path to run your app without having to activate/deactivate
the virtual environment.

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
        executable_path = %(HOME)s/bin
        
3. Change to the project root directory and source the dev scripts into your current shell session

        source dev.sh

4. Run `build`.

...and that's it. This will build a single file executable located in the
`./dist` directory with the name specified in your `config.ini`. Now you can
distribute your application by simply copying the file to the target system and
running it. No install required.

Note: Default build is for linux targets only. TODO: add Windows and MacOS targets.

## Development Helper Scripts

Running `installsrc` from method 1 above should be all you need to do to start
development, but here is the full list of helper scripts if you prefer a different
process:

    initenv: Create virtual environment and install application as editable
    startdev: Activates virtual environment
    stopdev: Deactivates virtual environment
    clean: Removes artifacts from prior builds if they exist
    rmenv: Removes virtual environment if it exists
    build: Builds project as single execuatable binary
    installsrc: Installs app from source and symlinks script to path
    link: Helper for installsrc to create symlink
