#!/bin/bash

set -e

trap 'last_command="$current_command"; current_command="$BASH_COMMAND"' DEBUG
trap 'echo "\"${last_command}\" exited with code $?"' EXIT


link_file() {
    src="$1"
    dest="$2"
  
    dateStr=$(date +%Y-%m-%dT%H%M%S)
  
    if [[ -h "$dest" ]]; then
      echo "Removing existing symlink: ${dest}"
      rm "${dest}"
    elif [[ -f "$dest" ]]; then
      echo "Backing up existing file: ${dest}"
      mv "$dest" "${dest}_${dateStr}"
  
    elif [[ -d "$dest" ]]; then
      echo "Backing up existing directory: ${dest}"
      mv "$dest" "${dest}_${dateStr}"
    fi
  
    echo "Linking file: ${dest}"
    ln -s "$src" "$dest"
}


ensure_bin_dir() {
    if [[ ! -e "${HOME}/bin" ]]; then
        mkdir -p "${HOME}/bin"
    fi
}

if [[ ! -e .env ]]; then
    virtualenv .env
fi

source .env/bin/activate

if [[ -n "$VIRTUAL_ENV" ]]; then
    pip install . && \
    ensure_bin_dir && \
    link_file "$(pwd)/.env/bin/cmd" "${HOME}/bin/cmd"
else
    echo "Something went wrong: failed to activate virtualenv."
    echo "Install aborted!"
    exit 1
fi
