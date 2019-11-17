#!/bin/bash

# Error Handling
set -e
# shellcheck disable=SC2154
trap 'last_command="$current_command"; current_command="$BASH_COMMAND"' DEBUG
# shellcheck disable=SC2154
trap '[[ $? != 0 ]] && echo "Install failed: \"${last_command}\" exited with code $?"' EXIT

# Path to symlink program main entry point. Should be added to PATH.
link_install_path="${HOME}/bin"

# Name of the command you'll use to run the program
cmd_name="cmd"

# Path to program main (executable entry point to link to PATH)
program_main_path="$(pwd)/.env/bin/${cmd_name}"


link_file() {
    src="$1"
    dest="$2"
  
    if [[ -h "$dest" ]]; then
        echo "Removing existing symlink: ${dest}..."
        rm "${dest}"
    elif [[ -f "$dest" || -d "$dest" ]]; then
        echo "File or directory already exists at location ${dest}"
        echo "Unable to complete install."
        echo "Please rename/relocate the existing file and try again."
        exit 1
    fi
  
    echo "Linking file: ${dest}"
    ln -s "$src" "$dest"
}

main() {
    mkdir -p "$link_install_path"
    
    [[ ! -e .env ]] && virtualenv .env || \
    echo "Using existing virtual environment..."

    # shellcheck disable=SC1091
    source .env/bin/activate

    if [[ -n "$VIRTUAL_ENV" ]]; then
        pip install . && \
        link_file "$program_main_path" "${link_install_path}/${cmd_name}"
        echo "Install succeeded!"
    else
        echo "Something went wrong: Failed to activate virtualenv."
        echo "Install aborted!"
        exit 1
    fi
}

main