# Safety Aliases
alias rm='rm -i'          # Always ask before deleting
alias cp='cp -i'          # Ask before overwriting
alias mv='mv -i'          # Ask before overwriting
alias ln='ln -i'          # Ask before overwriting symlinks
# Navigation Shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'         # Go back to previous directory
# Better Defaults
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias df='df -h'          # Human-readable disk space
alias du='du -h'          # Human-readable file sizes
alias free='free -h'      # Human-readable memory
alias mkdir='mkdir -pv'   # Create parent dirs and be verbose
# Git Shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git pull'
alias gph='git push'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gb='git branch'
alias gco='git checkout'
# Arch/Pacman Specific
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='pacman -Ss'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'  # Remove orphaned packages
# Common Typos
alias sl='ls'             # Typo fix
alias gti='git'           # Typo fix
alias clea='clear'        # Typo fix
# Quick System Info
alias ports='netstat -tulanp'
alias listening='lsof -i -P -n | grep LISTEN'
alias myip='curl ifconfig.me'
alias localip='ip addr show | grep "inet " | grep -v 127.0.0.1'
# File Operations
alias h='history'
alias hgrep='history | grep'
alias path='echo -e ${PATH//:/\\n}'  # Show PATH nicely
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
# Other
alias c='clear'
alias x='exit'
alias reload='source ~/.bashrc'
alias editbash='nvim ~/.bashrc'
alias b_a='nvim ~/.bash_aliases'
alias chnv='nvim ~/cheatsheets/nvim.md'
alias chnet='nvim ~/cheatsheets/network.md'
alias chtm='nvim ~/cheatsheets/tmux.txt'
alias chran='nvim ~/cheatsheets/ranger.txt'
alias tnew='tmux new -s'
alias t='tmux'
alias td='tmux detach'
alias ta='tmux attach'
alias tks='tmux kill-session'

alias myip='ip -4 addr show | grep "inet " | grep -v 127.0.0.1 | awk "{print \$2}" | cut -d/ -f1 | head -1'

# SSH aliases
alias ssh2014='ssh martin@192.168.1.181'

# Mount aliases
# Mount and work locally
alias dev2014='mount2014 && cd ~/mnt/macbook2014/projects'
alias mount2014='sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014'
alias umount2014='fusermount -u ~/mnt/macbook2014'
# Work on 2014 via tmux
alias work2014='ssh -t martin@192.168.1.181 "tmux attach || tmux"'
# Quick status checks
alias 2014-status='ssh martin@192.168.1.181 "echo \"=== MacBook 2014 ===\" && uname -a && uptime"'


# ============================================
# REMOTE DEVELOPMENT ON 2014 (HOME SERVER)
# ============================================

# Quick attach to main tmux session on 2014
alias dev='ssh -t martin@192.168.1.181 "tmux attach -t main || tmux new -s main"'

# Create new project session on 2014
devsession() {
    ssh -t martin@192.168.1.181 "tmux new -s $1"
}

# List tmux sessions on 2014
alias devls='ssh martin@192.168.1.181 "tmux ls"'

# Mount 2014 filesystem for file browsing
alias devmount='sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014'
alias devumount='fusermount -u ~/mnt/macbook2014'

# Quick access to 2014's projects
alias devcd='devmount && cd ~/mnt/macbook2014/projects'

# 2014 server status
alias devstatus='ssh martin@192.168.1.181 "echo \"=== Server Status ===\" && uptime && df -h | head -5 && free -h"'

# Restart 2014
alias devreboot='ssh -t martin@192.168.1.181 "sudo reboot"'

# My custom aliases
alias btry='echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)% - $(cat /sys/class/power_supply/BAT0/status)"'
alias ll='ls -lah'
alias update='sudo pacman -Syu'
alias start-dev='~/scripts/start-react-project.sh'
alias musb='sudo mount /dev/sdb1 /mnt/usb'

alias umusb='sudo umount /mnt/usb'
alias cd-usb='cd /mnt/usb/'
alias cd-ch='cd ~/cheatsheets/'
# Projector aliases
alias mirror='~/scripts/projector-mirror.sh'
alias projector='~/scripts/projector-only.sh'
alias laptop='~/scripts/laptop-only.sh'

# vpn custom alias
alias vpn='vpn-connect'
alias vpnoff='vpn-disconnect'
alias vinfo='vpn-info'
alias vswitch='vpn-switch'
alias vpnspeed='vpn-speedtest'
# Quick dotfiles management
alias dotfiles='cd ~/dotfiles && git status'
alias dotcommit='cd ~/dotfiles && git add -A && git commit -m'
alias dotpush='cd ~/dotfiles && git push'
alias dotquick='cd ~/dotfiles && git add -A && git commit -m "update configs" && git push'

# Cheatsheet aliases
alias githelp='cat ~/cheatsheets/git-quick.txt'
alias gitref='nvim ~/cheatsheets/git-reference.md'

# Cheatsheet aliases
alias githelp='cat ~/cheatsheets/git-quick.txt'
alias gitref='nvim ~/cheatsheets/git-reference.md'
alias tmuxhelp='cat ~/cheatsheets/tmux-quick.txt'
alias nvimhelp='cat ~/cheatsheets/nvim-advanced.txt'
alias yazihelp='cat ~/cheatsheets/yazi-quick.txt'
alias telehelp='cat ~/cheatsheets/telescope-quick.txt'
alias cheat='ls ~/cheatsheets/ && echo "Use: githelp, tmuxhelp, nvimhelp, yazihelp, telehelp"'

# Quick cheatsheet printer
qhelp() {
    case $1 in
        git) cat ~/cheatsheets/git-quick.txt ;;
        tmux) cat ~/cheatsheets/tmux-quick.txt ;;
        nvim) cat ~/cheatsheets/nvim-advanced.txt ;;
        yazi) cat ~/cheatsheets/yazi-quick.txt ;;
        tele*) cat ~/cheatsheets/telescope-quick.txt ;;
        *) echo "Available: git, tmux, nvim, yazi, telescope" ;;
    esac
}
alias bashhelp='cat ~/cheatsheets/bash-quick.txt'

# Updated qhelp with bash
qhelp() {
    case $1 in
        git) cat ~/cheatsheets/git-quick.txt ;;
        tmux) cat ~/cheatsheets/tmux-quick.txt ;;
        nvim) cat ~/cheatsheets/nvim-advanced.txt ;;
        yazi) cat ~/cheatsheets/yazi-quick.txt ;;
        tele*) cat ~/cheatsheets/telescope-quick.txt ;;
        bash) cat ~/cheatsheets/bash-quick.txt ;;
        *) echo "Available: git, tmux, nvim, yazi, telescope, bash" ;;
    esac
}

# Updated qhelp with bash
qhelp() {
    case $1 in
        git) cat ~/cheatsheets/git-quick.txt ;;
        tmux) cat ~/cheatsheets/tmux-quick.txt ;;
        nvim) cat ~/cheatsheets/nvim-advanced.txt ;;
        yazi) cat ~/cheatsheets/yazi-quick.txt ;;
        tele*) cat ~/cheatsheets/telescope-quick.txt ;;
        bash) cat ~/cheatsheets/bash-quick.txt ;;
        *) echo "Available: git, tmux, nvim, yazi, telescope, bash" ;;
    esac
}

# Search bash cheatsheet
bashfind() {
    grep -i "$1" ~/cheatsheets/bash-quick.txt
}
alias mdhelp='cat ~/cheatsheets/markdown-obsidian-quick.txt'
alias mdref='nvim ~/cheatsheets/markdown-reference.md'

# Updated qhelp with markdown
qhelp() {
    case $1 in
        git) cat ~/cheatsheets/git-quick.txt ;;
        tmux) cat ~/cheatsheets/tmux-quick.txt ;;
        nvim) cat ~/cheatsheets/nvim-advanced.txt ;;
        yazi) cat ~/cheatsheets/yazi-quick.txt ;;
        tele*) cat ~/cheatsheets/telescope-quick.txt ;;
        bash) cat ~/cheatsheets/bash-quick.txt ;;
        md|markdown|obsidian) cat ~/cheatsheets/markdown-obsidian-quick.txt ;;
        *) echo "Available: git, tmux, nvim, yazi, telescope, bash, markdown" ;;
    esac
}
