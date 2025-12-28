# Clean working bashrc

# Set a visible prompt
PS1='[\u@\h \W]\$ '

# Basic PATH
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/.bun/bin

# Electron apps use X11
export ELECTRON_OZONE_PLATFORM_HINT=x11

export SUDO_EDITOR=/usr/bin/nvim
export EDITOR=nvim
export VISUAL=nvim

# Start ssh-agent automatically
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) > /dev/null 2>&1
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Create new project session on 2014
devsession() {
    ssh -t martin@192.168.1.181 "tmux new -s $1"
}


# Kill tmux session on 2014
devkill() {
    ssh martin@192.168.1.181 "tmux kill-session -t $1"
}


# Copy file to/from 2014
toserver() {
    rsync -avz --progress "$1" martin@192.168.1.181:"${2:-~/}"
}
fromserver() {
    rsync -avz --progress martin@192.168.1.181:"$1" "${2:-.}"
}
# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.gz)   tar xzf "$1"   ;;
            *.tar.bz2)  tar xjf "$1"   ;;
            *.zip)      unzip "$1"     ;;
            *.rar)      unrar x "$1"   ;;
            *.7z)       7z x "$1"      ;;
            *)          echo "Don't know how to extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick backup of a file
backup() {
    cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
}

# Find process by name
psgrep() {
    ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# Start SSH agent automatically
if [ -z "$SSH_AUTH_SOCK" ]; then
   eval "$(ssh-agent -s)" > /dev/null
   ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi
# My custom dotfiles setup
