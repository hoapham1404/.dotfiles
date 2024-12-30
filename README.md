# .dotfiles
This is a repository for my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

## Requirements
- [GNU Stow](https://www.gnu.org/software/stow/)


## Installation
1. Clone the repository to your home directory.
2. run `./install.sh` to symlink the dotfiles to your home directory. Or you can run `stow <directory>` to symlink a specific directory.
3. Done!

## Uninstallation
1. run `./uninstall.sh` to remove the symlinks. Or you can run `stow -D <directory>` to remove the symlinks of a specific directory.
2. Done!
