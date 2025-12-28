# Dotfiles

Arch Linux configuration - minimal terminal-centric workflow on MacBook.

## Stack

- **OS**: Arch Linux
- **WM**: bspwm + sxhkd  
- **Bar**: polybar
- **Terminal**: kitty
- **Shell**: bash
- **Editor**: neovim
- **Multiplexer**: tmux
- **File Manager**: yazi, ranger
- **Browser**: LibreWolf with Tridactyl

## Installation
```bash
git clone git@github.com:tanssixyz/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Structure
```
config/     → ~/.config/
home/       → ~/
scripts/    → ~/.local/bin/ or ~/scripts/
```

## Manual Install
```bash
# Config items
ln -sf ~/dotfiles/config/* ~/.config/

# Home items  
ln -sf ~/dotfiles/home/.bashrc ~/.bashrc
ln -sf ~/dotfiles/home/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/home/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/home/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/home/.tmux ~/.tmux
ln -sf ~/dotfiles/home/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/home/.xinitrc ~/.xinitrc

# Scripts
mkdir -p ~/scripts
ln -sf ~/dotfiles/scripts/* ~/scripts/
```

## Notes

Email configs (neomutt, mbsync, msmtp) are not included for security.
ProtonVPN config excluded (contains auth).

## Post-Install Steps

### Tmux Plugin Manager

After installation, install tmux plugins:
```bash
# tmux plugin manager will be cloned on first run
# Press prefix + I (Ctrl-b + Shift-i) inside tmux to install plugins
```
