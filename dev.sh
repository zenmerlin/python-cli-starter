#!/bin/bash
# Utility functions used to script dev tasks. Source this file from the current
# directory to use. Tested with bash and zsh.

root_project_dir=$(pwd)
build_dir="${root_project_dir}/build"
dist_dir="${root_project_dir}/dist"
site_pkg_dir="${root_project_dir}/.env/lib/python3.7/site-packages"
bundle_name="cmd"

# Create virtual python environment, activate it, and install the python cli app
# as editable
initenv() {
    echo "Creating virtual environment..."
    if [[ -e "${root_project_dir}/.env" ]]; then \
        echo "Virtual environment '.env' already exists. Skipping..."
        return 0
    fi

    # shellcheck disable=SC1090,SC2015
    virtualenv "${root_project_dir}/.env" && \
    source "${root_project_dir}/.env/bin/activate" && \
    pip install --editable "${root_project_dir}" || \
    {
        ## Clean up .env file if failed
        [[ -e "${root_project_dir}/.env" ]] && \
            rm -rf "${root_project_dir}/.env"
        echo "ERROR: Failed to initialize virtual environment."
        return 1
    }

    echo "Virtual environment created successfully"
    return 0
}

# Activate virtual environment
startdev() {
    # shellcheck disable=SC1090
    source "${root_project_dir}/.env/bin/activate" || \
        { echo "Failed to activate virtual environment."; return 1; }
}

# Deactivate virtual environment
stopdev() {
    [[ -n "$VIRTUAL_ENV" ]] && deactivate || \
    echo "Virtual environment is not activated. No action taken."
}

# Remove build build artifacts if they exist
clean() {
    # This currently removes the spec file as well as dist and build dirs. May
    # want to use the spec file for the build in the future.
    startdev || \
        { echo "Please run initenv and try again"; return 1; }
    
    echo "Removing build artifacts..."

    local bundle_name
    bundle_name="$(python get_config.py installation executable)" || \
        { echo "Error: Failed reading config.ini"; stopdev; return 1; }

    [[ -e "${root_project_dir}/${bundle_name}.spec" ]] && \
        rm "${root_project_dir}/${bundle_name}.spec"
    [[ -e "$build_dir" ]] && rm -r "$build_dir"
    [[ -e "$dist_dir" ]] && rm -r "$dist_dir"
    
    echo "Done."
    stopdev
}

rmenv() {
    echo "Removing virtual environment..."
    [[ -e "${root_project_dir}/.env" ]] && \
        rm -rf "${root_project_dir}/.env" && \
        echo "Virtual environment removed." || \
        echo "Error: Removal failed. Check to see if '.env' dir exists."
}

# Compile and bundle application into a single executable
build() {
    local bundle_name
    initenv || return 1
    startdev
    bundle_name="$(python get_config.py installation executable)" || \
        { echo "Error: Failed reading config.ini"; stopdev; return 1; }

    clean
    # Remove --onefile to create a build directory 
    pyinstaller --onefile \
        --paths "$site_pkg_dir" \
        --name "$bundle_name" \
        "${root_project_dir}/cli.py"

    # Deactivate the virtual environment activated by initenv
    [[ -n "$VIRTUAL_ENV" ]] && deactivate 
}
