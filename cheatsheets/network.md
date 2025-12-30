# Network & Remote Development Cheatsheet

**MacBook Air 2017 & 2014 - Complete Reference Guide**

---

## 🎯 QUICK REFERENCE

### Your Network Setup

- **2017 (archbook2017):** `192.168.1.57` - Main workstation, US keyboard
- **2014 (archbook2014):** `192.168.1.181` - Home server, backup

### Essential Aliases (Add to ~/.bashrc)

```bash
# SSH shortcuts
alias ssh2014='ssh martin@192.168.1.181'
alias ssh2017='ssh martin@192.168.1.57'

# Development work on server
alias dev='ssh -t martin@192.168.1.181 "tmux attach -t main || tmux new -s main"'

# Mount/unmount filesystems
alias mount2014='sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014'
alias umount2014='fusermount -u ~/mnt/macbook2014'
alias mount2017='sshfs martin@192.168.1.57:/home/martin ~/mnt/macbook2017'
alias umount2017='fusermount -u ~/mnt/macbook2017'

# Status checks
alias myip='ip -4 addr show | grep "inet " | grep -v 127.0.0.1 | awk "{print \$2}" | cut -d/ -f1 | head -1'
alias devstatus='ssh martin@192.168.1.181 "uptime && df -h | head -5"'
```

---

## 📡 NETWORKING BASICS

### Check Your IP Address

```bash
# Method 1: Simple
ip -4 addr show | grep "inet " | grep -v 127.0.0.1

# Method 2: Even simpler
myip

# Method 3: Show interface details
ip addr show wlp3s0
```

### Test Connectivity

```bash
# Ping test (Ctrl+C to stop)
ping 192.168.1.181
ping 192.168.1.57

# Check if SSH port is open
nc -zv 192.168.1.181 22

# Scan local network (see all devices)
nmap -sn 192.168.1.0/24
```

### Find Devices on Network

```bash
# See all devices
sudo nmap -sP 192.168.1.0/24

# Show hostnames
arp -a
```

---

## 🔐 SSH - REMOTE ACCESS

### Basic SSH Commands

```bash
# Connect to remote machine
ssh username@hostname
ssh martin@192.168.1.181

# Connect with alias
ssh2014

# Run single command remotely
ssh martin@192.168.1.181 'ls -la'
ssh martin@192.168.1.181 'uname -a'

# Run command requiring terminal (sudo, interactive)
ssh -t martin@192.168.1.181 'sudo reboot'
ssh -t martin@192.168.1.181 'sudo pacman -S package'

# Connect and auto-run tmux
ssh -t martin@192.168.1.181 'tmux attach || tmux'
```

### SSH Keys (Password-less Login)

```bash
# Generate SSH key (one time setup)
ssh-keygen -t ed25519 -C "macbook2017"
# Press Enter for default location
# Set passphrase or leave empty

# Copy key to remote machine
ssh-copy-id martin@192.168.1.181

# Test - should login without password
ssh martin@192.168.1.181

# If you set a passphrase, use ssh-agent:
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_ed25519
# Now won't ask for passphrase this session
```

### SSH Config (~/.ssh/config)

```bash
# Create config file
nano ~/.ssh/config

# Add:
Host server
    HostName 192.168.1.181
    User martin
    ServerAliveInterval 60
    ServerAliveCountMax 3

Host dev
    HostName 192.168.1.181
    User martin
    RequestTTY yes
    RemoteCommand tmux attach -t main || tmux new -s main

# Now use:
ssh server  # Normal SSH
ssh dev     # Auto-attach to tmux
```

### SSH Port Forwarding

```bash
# Forward remote port to local
# Pattern: ssh -L local_port:localhost:remote_port user@host
ssh -L 8080:localhost:3000 martin@192.168.1.181
# Now http://localhost:8080 shows remote's :3000

# Forward multiple ports
ssh -L 3000:localhost:3000 -L 8080:localhost:8080 martin@192.168.1.181

# Background forwarding
ssh -fN -L 3000:localhost:3000 martin@192.168.1.181
# -f = background, -N = no command

# Kill background SSH
ps aux | grep ssh
kill [PID]
```

---

## 📂 FILE OPERATIONS

### SCP - Secure Copy

#### Copy TO Remote

```bash
# Single file
scp /local/file.txt martin@192.168.1.181:~/

# With specific destination
scp /local/file.txt martin@192.168.1.181:~/documents/

# Entire directory (-r = recursive)
scp -r /local/folder martin@192.168.1.181:~/backup/

# Multiple files
scp file1.txt file2.txt martin@192.168.1.181:~/

# From 2017 to 2014
scp ~/project.zip martin@192.168.1.181:~/backups/
```

#### Copy FROM Remote

```bash
# Single file from remote
scp martin@192.168.1.181:~/file.txt ~/downloads/

# Directory from remote
scp -r martin@192.168.1.181:~/projects ~/local-backup/

# From 2014 to 2017
scp martin@192.168.1.181:~/important.doc ~/documents/
```

#### SCP Options

```bash
# Preserve timestamps and permissions
scp -p file.txt martin@192.168.1.181:~/

# Limit bandwidth (KB/s)
scp -l 1000 large-file.tar.gz martin@192.168.1.181:~/

# Use specific port
scp -P 2222 file.txt martin@192.168.1.181:~/

# Quiet mode (no progress)
scp -q file.txt martin@192.168.1.181:~/
```

---

### RSYNC - Smart Sync (BETTER!)

#### Why Rsync is Better

- Shows progress
- Only copies changed files
- Can resume interrupted transfers
- Faster for large directories
- More options for filtering

#### Basic Rsync Syntax

```bash
# Basic copy TO remote
rsync -avz /local/file.txt martin@192.168.1.181:~/

# Basic copy FROM remote
rsync -avz martin@192.168.1.181:~/file.txt ~/local/

# Common flags:
# -a = archive (preserves everything)
# -v = verbose (shows files)
# -z = compress (faster over network)
# --progress = show progress bar
# --delete = delete files on destination not in source
```

#### Rsync Examples

```bash
# Copy directory with progress
rsync -avz --progress ~/projects/my-app/ martin@192.168.1.181:~/projects/my-app/

# Sync and show what would change (dry run)
rsync -avz --dry-run --delete ~/projects/ martin@192.168.1.181:~/backup/

# Sync excluding certain files
rsync -avz --exclude='node_modules' --exclude='.git' ~/project/ martin@192.168.1.181:~/project/

# Mirror directory (delete extra files)
rsync -avz --delete ~/projects/ martin@192.168.1.181:~/backup/

# Sync only specific file types
rsync -avz --include='*.js' --exclude='*' ~/src/ martin@192.168.1.181:~/src/

# Resume interrupted transfer
rsync -avz --partial ~/large-file.tar.gz martin@192.168.1.181:~/
```

#### Rsync for Backups

```bash
# Daily backup from 2017 to 2014
rsync -avz --delete \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='build' \
  --exclude='.cache' \
  ~/projects/ martin@192.168.1.181:~/backups/projects-$(date +%Y%m%d)/

# Incremental backup (hardlinks to save space)
rsync -avz --link-dest=~/backups/latest ~/projects/ martin@192.168.1.181:~/backups/$(date +%Y%m%d)/
```

---

### SSHFS - Mount Remote Filesystem

#### What is SSHFS?

Mount a remote directory as if it's local. Edit files with local tools, changes save to remote.

#### Install SSHFS

```bash
# On both machines
sudo pacman -S sshfs
```

#### Mount Remote Directory

```bash
# Create mount point
mkdir -p ~/mnt/macbook2014

# Mount 2014's home on 2017
sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014

# Now access 2014's files:
ls ~/mnt/macbook2014
cd ~/mnt/macbook2014/projects
nvim ~/mnt/macbook2014/file.txt

# Unmount when done
fusermount -u ~/mnt/macbook2014
# or
umount ~/mnt/macbook2014
```

#### SSHFS Options

```bash
# Mount with options
sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014 \
  -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3

# Mount specific directory
sshfs martin@192.168.1.181:/home/martin/projects ~/mnt/remote-projects

# Mount with compression (faster)
sshfs -C martin@192.168.1.181:/home/martin ~/mnt/macbook2014

# Mount with specific permissions
sshfs -o uid=$(id -u),gid=$(id -g) martin@192.168.1.181:/home/martin ~/mnt/macbook2014
```

#### SSHFS Troubleshooting

```bash
# If mount is frozen/unresponsive
fusermount -uz ~/mnt/macbook2014

# Force unmount
sudo umount -f ~/mnt/macbook2014

# Check if mounted
mount | grep sshfs

# Remount if connection dropped
fusermount -u ~/mnt/macbook2014
sshfs martin@192.168.1.181:/home/martin ~/mnt/macbook2014
```

---

## 💾 BACKUP STRATEGIES

### Strategy 1: Manual Backup Script

```bash
#!/bin/bash
# ~/backup-to-2014.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="backups/backup_$TIMESTAMP"

echo "🔄 Backing up to 2014..."

# Projects (excluding build artifacts)
rsync -avz --delete \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='build' \
  --exclude='.git' \
  ~/projects/ martin@192.168.1.181:~/$BACKUP_DIR/projects/

# Configs
rsync -avz ~/.config ~/. ~/backups/ martin@192.168.1.181:~/$BACKUP_DIR/configs/

echo "✅ Backup complete: $BACKUP_DIR"
```

### Strategy 2: Incremental Sync

```bash
#!/bin/bash
# Sync working projects (not full backup)

echo "🔄 Syncing projects..."

rsync -avz --delete \
  --exclude='node_modules' \
  --exclude='.git' \
  ~/projects/ martin@192.168.1.181:~/projects-mirror/

echo "✅ Projects synced"
```

### Strategy 3: Automated Daily Backup (on 2014)

```bash
# On 2014, create ~/scripts/backup.sh
#!/bin/bash
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d)
BACKUP_PATH="$BACKUP_DIR/backup_$DATE"

mkdir -p "$BACKUP_PATH"

# Backup projects
rsync -a --exclude='node_modules' ~/projects/ "$BACKUP_PATH/projects/"

# Backup configs
rsync -a ~/.config "$BACKUP_PATH/"
cp ~/.bashrc ~/.tmux.conf "$BACKUP_PATH/"

# Keep only last 7 days
find "$BACKUP_DIR" -name "backup_*" -mtime +7 -exec rm -rf {} \;

echo "✅ Backup complete: $BACKUP_PATH"

# Add to crontab (runs daily at 2 AM):
# crontab -e
# 0 2 * * * /home/martin/scripts/backup.sh >> /home/martin/logs/backup.log 2>&1
```

### Strategy 4: Git-based Backup

```bash
# Initialize git repo on 2014 for important files
ssh martin@192.168.1.181
mkdir -p ~/git-backups/configs
cd ~/git-backups/configs
git init

# Add configs
cp -r ~/.config .
cp ~/.bashrc ~/.tmux.conf .
git add .
git commit -m "Backup $(date +%Y%m%d)"

# From 2017, clone and have instant backup
git clone martin@192.168.1.181:~/git-backups/configs ~/local-config-backup
```

---

## 🖥️ TMUX - PERSISTENT SESSIONS

### Why Tmux?

- Sessions survive disconnections
- Work continues even when you close terminal
- Multiple windows/panes in one session
- Perfect for remote development

### Essential Tmux Commands

#### Session Management

```bash
# Create new session
tmux new -s myproject

# List sessions
tmux ls

# Attach to session
tmux attach -t myproject
tmux a -t myproject

# Detach (while in tmux)
Ctrl+a d

# Kill session
tmux kill-session -t myproject

# Rename session (while in tmux)
Ctrl+a $
```

#### Window Management (like tabs)

```bash
# Create new window
Ctrl+a c

# Rename window
Ctrl+a ,

# Next/previous window
Ctrl+a n  (next)
Ctrl+a p  (previous)
Shift+Right  (next, no prefix)
Shift+Left   (previous, no prefix)

# Jump to window number
Ctrl+a 0-9

# Close window
Ctrl+a &
# or just: exit
```

#### Pane Management (split screen)

```bash
# Split vertically
Ctrl+a |

# Split horizontally
Ctrl+a -

# Navigate panes
Alt+Left/Right/Up/Down  (no prefix!)

# Resize panes
Ctrl+a Ctrl+Left/Right/Up/Down

# Close pane
Ctrl+a x
# or: exit

# Zoom pane (fullscreen toggle)
Ctrl+a z

# Swap panes
Ctrl+a {  (swap left)
Ctrl+a }  (swap right)
```

#### Copy Mode (scroll & search)

```bash
# Enter copy mode
Ctrl+a [

# Navigate
Arrow keys, PgUp/PgDn
q to quit

# Search
? (search backward)
/ (search forward)
n (next match)
N (previous match)
```

### Tmux Workflow Examples

#### Example 1: Development Session

```bash
# Create project session
tmux new -s myapp

# Window 0: Code
nvim .

# Create window 1: Server
Ctrl+a c
Ctrl+a , "server"
bun dev

# Create window 2: Terminal
Ctrl+a c
Ctrl+a , "terminal"

# Create window 3: Git
Ctrl+a c
Ctrl+a , "git"

# Navigate between windows
Shift+Left/Right

# Detach
Ctrl+a d

# Later, reattach
tmux attach -t myapp
```

#### Example 2: Split Screen Development

```bash
# Start session
tmux new -s dev

# Split vertically (code | server)
Ctrl+a |

# Left pane: code
nvim src/App.jsx

# Right pane: server
Alt+Right
bun dev

# Split right pane horizontally (server on top, terminal below)
Ctrl+a -

# Navigate freely
Alt+Arrow keys
```

#### Example 3: Remote Development from 2017

```bash
# From 2017, connect to 2014's tmux
ssh -t martin@192.168.1.181 'tmux attach -t main || tmux new -s main'

# Or use alias
dev

# Work all day in tmux on 2014

# Close laptop, go home
Ctrl+a d

# At home, reconnect
dev
# Everything exactly as you left it!
```

---

## 🔧 PRACTICAL WORKFLOWS

### Workflow 1: Edit on 2017, Run on 2014

```bash
# On 2017: Mount 2014's filesystem
mount2014

# Edit files locally
cd ~/mnt/macbook2014/projects/my-app
nvim src/index.js

# In another terminal, run on 2014
ssh martin@192.168.1.181 'cd ~/projects/my-app && bun dev'

# Access server from 2017
ssh -L 3000:localhost:3000 martin@192.168.1.181
# Open browser: http://localhost:3000
```

### Workflow 2: Full Remote Development

```bash
# From 2017, SSH to 2014 with tmux
dev

# Everything runs on 2014:
cd ~/projects/my-app
nvim .

# Split for server
Ctrl+a |
bun dev

# Work entirely on 2014, accessed from 2017
```

### Workflow 3: Sync and Work Locally

```bash
# Sync project from 2014 to 2017
rsync -avz martin@192.168.1.181:~/projects/my-app ~/projects/

# Work on 2017
cd ~/projects/my-app
nvim .
bun dev

# Sync back to 2014 when done
rsync -avz ~/projects/my-app martin@192.168.1.181:~/projects/
```

### Workflow 4: Cross-Machine Development

```bash
# 2014: Run backend
ssh2014
cd ~/projects/api
tmux new -s api
bun run start
Ctrl+a d

# 2017: Run frontend (connecting to 2014's API)
cd ~/projects/frontend
# Point to 2014's API: http://192.168.1.181:8080
bun dev
```

---

## 🛠️ USEFUL COMMANDS

### System Information

```bash
# Check hostname
cat /etc/hostname
# or
uname -n

# System info
uname -a
neofetch

# Uptime
uptime

# Disk usage
df -h

# Memory usage
free -h

# CPU info
lscpu

# Running processes
ps aux
top
htop
```

### Network Monitoring

```bash
# Active connections
ss -tuln
netstat -tuln

# What's using a port
sudo ss -tulpn | grep :3000

# Network interface stats
ip -s link

# Monitor traffic
sudo nethogs
sudo iftop

# DNS lookup
nslookup google.com
dig google.com
```

### File Operations

```bash
# Find files
find ~/projects -name "*.js"
find ~/projects -type f -mtime -7  # Modified last 7 days

# Search in files
grep -r "TODO" ~/projects
grep -r "function" ~/projects --include="*.js"

# Disk usage of directory
du -sh ~/projects
du -h ~/projects | sort -h

# Compare directories
diff -qr ~/projects ~/backup

# Archive and compress
tar -czf backup.tar.gz ~/projects
tar -xzf backup.tar.gz

# Check file permissions
ls -la file.txt
stat file.txt
```

---

## 🔐 SECURITY BEST PRACTICES

### SSH Security

```bash
# Use SSH keys, not passwords
ssh-keygen -t ed25519

# Set proper permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/authorized_keys

# Disable password auth in /etc/ssh/sshd_config:
# PasswordAuthentication no
# PubkeyAuthentication yes

# Change SSH port (optional)
# Port 2222

# Restart SSH after config changes
sudo systemctl restart sshd
```

### Firewall Rules

```bash
# Allow SSH from local network only
sudo ufw allow from 192.168.1.0/24 to any port 22

# Check firewall status
sudo ufw status

# Enable firewall
sudo ufw enable
```

### File Permissions

```bash
# Make file executable
chmod +x script.sh

# Make file private
chmod 600 private.txt

# Set directory permissions
chmod 755 ~/projects

# Change ownership
chown martin:martin file.txt
```

---

## ⚡ TROUBLESHOOTING

### SSH Issues

```bash
# Connection refused
# - Check if SSH is running: systemctl status sshd
# - Check firewall: sudo ufw status
# - Test connectivity: ping 192.168.1.181

# Permission denied
# - Check ~/.ssh/authorized_keys permissions (600)
# - Check home directory permissions (755)
# - Check SSH key: ssh -v martin@192.168.1.181

# Connection timeout
# - Check IP address: ip a
# - Check route: ip route
# - Check both machines on same network

# Too many authentication failures
# - Limit keys: ssh -o IdentitiesOnly=yes martin@192.168.1.181
```

### SSHFS Issues

```bash
# Mount fails
# - Check SSH works: ssh martin@192.168.1.181
# - Check mount point exists: mkdir -p ~/mnt/macbook2014

# Connection frozen
# - Force unmount: fusermount -uz ~/mnt/macbook2014
# - Remount: mount2014

# Transport endpoint not connected
# - Unmount: fusermount -u ~/mnt/macbook2014
# - Remount: mount2014
```

### Network Issues

```bash
# Check network is up
ip link show wlp3s0

# Check if connected
nmcli device status

# Restart NetworkManager
sudo systemctl restart NetworkManager

# Check DNS
cat /etc/resolv.conf
ping 8.8.8.8  (Google DNS)
```

---

## 📚 LEARNING PATH

### Week 1: Master Basic SSH

- [ ] SSH between machines without passwords
- [ ] Run remote commands
- [ ] Understand SSH config
- [ ] Practice daily SSH usage

### Week 2: File Operations

- [ ] Copy files with scp
- [ ] Sync with rsync
- [ ] Mount with SSHFS
- [ ] Create backup script

### Week 3: Tmux Proficiency

- [ ] Work entirely in tmux
- [ ] Use multiple windows
- [ ] Split panes effectively
- [ ] Never lose work due to disconnection

### Week 4: Advanced Workflows

- [ ] Port forwarding
- [ ] Cross-machine development
- [ ] Automated backups
- [ ] Perfect your dotfiles

---

## 🎯 QUICK SCENARIOS

### "I want to edit a file on 2014 from 2017"

```bash
# Option 1: Mount and edit
mount2014
nvim ~/mnt/macbook2014/file.txt

# Option 2: SSH and edit
ssh2014
nvim file.txt
```

### "I want to backup my projects"

```bash
# From 2017 to 2014
rsync -avz --exclude='node_modules' ~/projects/ martin@192.168.1.181:~/backups/
```

### "I want to work on 2014 but use 2017's keyboard"

```bash
# Use tmux session
dev
# Work entirely on 2014, accessed from 2017
```

### "I want to run dev server on 2014, access from 2017"

```bash
# On 2014 via SSH
ssh2014
cd ~/project
bun dev

# On 2017, forward port
ssh -L 3000:localhost:3000 martin@192.168.1.181

# Open browser: http://localhost:3000
```

### "My SSH connection dropped, did I lose my work?"

```bash
# If you were in tmux: NO!
ssh2014
tmux attach
# Everything is there!
```

### "How do I copy my entire config to 2014?"

```bash
rsync -avz ~/.config/nvim/ martin@192.168.1.181:~/.config/nvim/
```

---

## 📖 COMMAND REFERENCE CARD

### Print this section for quick reference!

```
SSH
  ssh user@host                    Connect
  ssh user@host 'command'          Run command
  ssh -t user@host 'command'       Interactive command
  ssh-copy-id user@host            Copy SSH key

SCP
  scp file user@host:path          Copy to remote
  scp user@host:file path          Copy from remote
  scp -r dir user@host:path        Copy directory

RSYNC
  rsync -avz src user@host:dest    Sync to remote
  rsync -avz user@host:src dest    Sync from remote
  --progress                       Show progress
  --delete                         Delete extra files
  --exclude='pattern'              Exclude files

SSHFS
  sshfs user@host:path mountpoint  Mount remote
  fusermount -u mountpoint         Unmount

TMUX
  tmux new -s name                 New session
  tmux attach -t name              Attach
  Ctrl+a d                         Detach
  Ctrl+a c                         New window
  Ctrl+a |                         Split vertical
  Ctrl+a -                         Split horizontal
  Alt+Arrows                       Navigate panes

NETWORK
  ip addr show                     Show IPs
  ping host                        Test connectivity
  ssh user@host                    Connect via SSH
  systemctl status sshd            Check SSH daemon
```

---

## 💡 PRO TIPS

1. **Always use tmux for remote work** - Never lose work
2. **Name your tmux sessions** - Easy to find later
3. **Use rsync, not scp** - Faster, smarter, resumable
4. **Mount with SSHFS for browsing** - Use local tools on remote files
5. **Port forward for dev servers** - Test on 2017, run on 2014
6. **Backup before experimenting** - Especially system configs
7. **Use SSH config** - Shorter commands, more convenience
8. **Check your workflow daily** - Small iterations improve efficiency
9. **Document your changes** - Future you will thank present you
10. **Practice in safe environment** - Use test directories first

---

## 🔗 USEFUL LINKS

- SSH Manual: `man ssh`
- Rsync Manual: `man rsync`
- Tmux Manual: `man tmux`
- SSHFS Manual: `man sshfs`
- Arch Wiki SSH: https://wiki.archlinux.org/title/SSH
- Arch Wiki Tmux: https://wiki.archlinux.org/title/Tmux

---

**Last Updated:** December 2024
**Author:** Learning journey on Arch Linux
**Network:** MacBook Air 2017 & 2014

**Remember:** The best way to learn is by doing! Practice these commands daily until they become second nature. 🚀
