#!/bin/bash

# Dotfiles installation script
set -e

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles from $DOTFILES"
echo ""

# Create .config if it doesn't exist
mkdir -p ~/.config

# Backup existing configs
BACKUP="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP"

echo "Backing up existing configs to $BACKUP..."

# Backup function
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "  Backing up $1"
        cp -r "$1" "$BACKUP/"
    fi
}

# Backup configs
backup_if_exists ~/.config/nvim
backup_if_exists ~/.config/bspwm
backup_if_exists ~/.config/sxhkd
backup_if_exists ~/.config/kitty
backup_if_exists ~/.config/yazi
backup_if_exists ~/.config/polybar
backup_if_exists ~/.bashrc
backup_if_exists ~/.tmux
backup_if_exists ~/.tmux.conf

echo ""
echo "Creating symlinks..."

# Link config items
for item in "$DOTFILES/config"/*; do
    name=$(basename "$item")
    target="$HOME/.config/$name"
    
    # Remove if exists
    rm -rf "$target"
    
    # Create symlink
    ln -sf "$item" "$target"
    echo "  Linked ~/.config/$name"
done

# Link home items
ln -sf "$DOTFILES/home/.bashrc" ~/.bashrc
ln -sf "$DOTFILES/home/.bash_profile" ~/.bash_profile
ln -sf "$DOTFILES/home/.bash_aliases" ~/.bash_aliases
ln -sf "$DOTFILES/home/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/home/.tmux" ~/.tmux
ln -sf "$DOTFILES/home/.tmux.conf" ~/.tmux.conf
ln -sf "$DOTFILES/home/.xinitrc" ~/.xinitrc

echo "  Linked home configs"

# Link scripts
mkdir -p ~/scripts
for script in "$DOTFILES/scripts"/*; do
    if [ -f "$script" ]; then
        name=$(basename "$script")
        ln -sf "$script" ~/scripts/"$name"
    fi
done
echo "  Linked scripts to ~/scripts/"

echo ""
echo "✓ Dotfiles installed!"
echo ""
echo "Backup saved to: $BACKUP"
echo ""
echo "Next steps:"
echo "  - Source bashrc: source ~/.bashrc"
echo "  - Restart bspwm: Super+Shift+R"
echo "  - Set up email configs separately (not in dotfiles)"
