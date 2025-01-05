# .dotfiles
This is a repository for my dotfiles. I use [GNU Stow](https://www.gnu.org/software/stow/) to manage them.

## Requirements
- **Quick Installation**: Download `./debian_install.sh` and run it. It will install all the required packages for you.
### 1. Tmux
- fzf

### 2. Neovim
- Node.js (for Copilot)
- xclip (for clipboard support)

### 3. AwesomeWM
- brightnessctl (for brightness control)
- acpi (for battery status)


## Installation
1. Clone the repository to your home directory.
    ```bash
    git clone --recurse-submodules git@github.com:hoapham2k2/.dotfiles.git ~/dotfiles
    ```
2. Symlink the dotfiles to your home directory. 
    ```bash
    cd ~/dotfiles
    ./install.sh
    ```
3. Done!

## Uninstallation
1. run `./uninstall.sh` to remove the symlinks. 
    ```bash
    cd ~/dotfiles
    ./clean-env.sh
    ```
2. Done!
