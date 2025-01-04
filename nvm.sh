#!/bin/bash

# Function to check if nvm is already installed
check_nvm_installed() {
    if [ -d "$HOME/.nvm" ]; then
        echo "NVM is already installed at $HOME/.nvm."
        return 0
    fi
    return 1
}

# Install NVM
install_nvm() {
    echo "Installing NVM..."

    # Download and run the install script from the official repository
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

    # Load NVM environment for immediate use
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Verify installation
    if command -v nvm &> /dev/null; then
        echo "NVM installation successful. Version: $(nvm --version)"
    else
        echo "NVM installation failed."
        exit 1
    fi
}

# Set default Node.js version to LTS
set_nvm_default_lts() {
    echo "Ensuring NVM uses the latest LTS version of Node.js by default..."

    # Load NVM environment (in case it's not loaded)
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Install the latest LTS version of Node.js and set it as default
    nvm install --lts
    nvm alias default lts/*

    echo "Default Node.js version set to LTS: $(nvm current)"
}

# Main script execution
if check_nvm_installed; then
    echo "NVM is already installed. Proceeding to set default Node.js version to LTS..."
else
    install_nvm
fi

# Ensure default Node.js version is LTS
set_nvm_default_lts

