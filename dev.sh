#!/bin/bash
# Utility functions used to script dev tasks. Source this file from the current
# directory to use. Tested with bash and zsh.

ROOT_PROJECT_DIR=$(pwd)

# Create virtual python environment, activate it, and install the python cli app
# as editable
initdev() {
    # shellcheck disable=SC1090
    [[ ! -e "${ROOT_PROJECT_DIR}/.env" ]] && \
    virtualenv "${ROOT_PROJECT_DIR}/.env" && \
    source "${ROOT_PROJECT_DIR}/.env/bin/activate" && \
    pip install --editable "${ROOT_PROJECT_DIR}" || \
    echo "Failed to initialize virtual environment"
}

# Activate virtual environment
startdev() {
    # shellcheck disable=SC1090
    source "${ROOT_PROJECT_DIR}/.env/bin/activate" || \
    echo "Failed to activate virtual environment."
}

# Deactivate virtual environment
stopdev() {
    [[ -n "$VIRTUAL_ENV" ]] && deactivate || \
    echo "Virtual environment is not activated. No action taken."
}
