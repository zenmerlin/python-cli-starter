#!/bin/bash

# Error Handling
set -e
# shellcheck disable=SC2154
trap 'last_command="$current_command"; current_command="$BASH_COMMAND"' DEBUG
# shellcheck disable=SC2154
trap '[[ $? != 0 ]] && echo "Install failed: \"${last_command}\" exited with code $?"' EXIT

# Path where executable main script is located in virtual env 
program_main_path="$(pwd)/.env/bin"

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
    executable="$1"
    executable_path="$2"

    mkdir -p "$executable_path"
    
    [[ ! -e .env ]] && virtualenv .env || \
    echo "Using existing virtual environment..."

    "${program_main_path}/pip" install --no-warn-script-location . && \
    link_file \
        "${program_main_path}/${executable}" \
        "${executable_path}/${executable}"
    echo "Install succeeded!"
}

main "$1" "$2"