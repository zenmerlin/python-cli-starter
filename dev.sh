# Utility functions used to script dev tasks. Source this file from the current
# directory to use. Tested with bash and zsh.

ROOT_PROJECT_DIR=$(pwd)

# Create virtual python environment, activate it, and install the python cli app
# as editable
env-init() {
    cd "${ROOT_PROJECT_DIR}" && \
    virtualenv .env && \
    source .env/bin/activate && \
    pip install --editable .
}

# Install in virtual environment
env-install() {
    cd "${ROOT_PROJECT_DIR}"
    if [[ -z "$VIRTUAL_ENV" ]]; then
        source .env/bin/activate && \
        pip install --editable .
    fi
}

# Activate virtual environment
start-dev() {
    cd "${ROOT_PROJECT_DIR}" && \
    source .env/bin/activate
}

# Deactivate virtual environment
stop-dev() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    else
        echo "Virtual environment is not activated. No action taken."
    fi
}