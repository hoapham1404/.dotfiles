#!/bin/bash

# Directory containing the dotfiles repository
DOTFILES_DIR="$(dirname "$(readlink -f "$0")")"

## Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || { echo "Failed to navigate to $DOTFILES_DIR"; exit 1; }

## Loop through each folder in the directory and run `stow -D`
for folder in */; do
    folder_name="${folder%/}" # Remove trailing slash
    echo "Removing symlinks for $folder_name..."
    stow -D "$folder_name"
done

echo "Environment cleaned!"
