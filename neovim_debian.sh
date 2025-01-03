#!/bin/bash

# Remove Neovim if already installed
echo "Removing any existing Neovim installation..."
sudo apt remove -y neovim

# Install necessary dependencies
echo "Installing necessary dependencies..."
sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl

# Clone Neovim repository
echo "Cloning Neovim repository..."
git clone https://github.com/neovim/neovim
cd neovim

# Build Neovim
echo "Building Neovim..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# List files to confirm build
ls

# Navigate to the build directory
cd build

# Create .deb package
echo "Creating .deb package..."
cpack -G DEB

# Install the generated .deb package
echo "Installing Neovim..."
sudo dpkg -i --force-overwrite nvim-linux64.deb

# Confirm installation by running nvim
echo "Neovim installed successfully. Launching Neovim..."
nvim

