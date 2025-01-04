#!/bin/bash

# Define mandatory packages
mandatory="git fzf curl stow"

# Convert the list into an array
IFS=" " read -r -a mandatory_array <<<"$mandatory"

# Inform the user
echo "Checking for mandatory packages: $mandatory"

# Check and install missing packages
missing_packages=() 
for item in "${mandatory_array[@]}"; do
    echo -n "Checking $item... "
    if ! command -v "$item" &> /dev/null; then
        echo "Not installed."
        missing_packages+=("$item")
    else
        echo "Already installed."
    fi
done

# Install missing packages
if [ "${#missing_packages[@]}" -ne 0 ]; then
    echo "Installing missing packages: ${missing_packages[*]}"
    sudo apt update && sudo apt install -y "${missing_packages[@]}"
    if [ $? -eq 0 ]; then
        echo "All packages installed successfully."
    else
        echo "Failed to install some packages. Please check your internet connection or package names."
    fi
else
    echo "All mandatory packages are already installed."
fi
