# Arch Linux System Maintenance Cheat Sheet
**Keep Your System Healthy, Safe, and Running Smooth**

---
# Every week, run these commands:
```bash
yay -Syu                              # Update everything
sudo pacman -Rns $(pacman -Qtdq)      # Remove orphans
sudo paccache -r                       # Clean old packages
systemctl --failed                     # Check for issues
df -h                                   # Check disk space
```                                 

## 📅 DAILY / REGULAR TASKS

### System Updates (Do This Regularly!)

```bash
# Update official packages + AUR packages (recommended)
yay -Syu

# Or update official packages only
sudo pacman -Syu

# Check for updates without installing
yay -Qu

# Update everything and clean cache
yay -Syu --cleanafter
```

**How often?** 
- 🟢 **Every few days** for desktop use
- 🟡 **Weekly** is acceptable
- 🔴 **Don't go more than 2 weeks** without updating

**Why?** Security patches, bug fixes, new features.

---

## 🔒 SECURITY BEST PRACTICES

### VPN Usage
```bash
# Connect VPN before sensitive browsing
vpn-on

# Disconnect when you need speed
vpn-off

# Check VPN is working
curl ifconfig.me              # Should show VPN IP
cat /etc/resolv.conf          # Check DNS servers
```

**Use VPN for:**
- ✅ Online banking
- ✅ Shopping with credit cards
- ✅ Public WiFi
- ✅ Sensitive research
- ✅ Accessing blocked content

**Don't need VPN for:**
- ❌ General browsing (it's slow)
- ❌ Streaming (slow + blocked)
- ❌ Local network tasks

---

### Firewall Status
```bash
# Check firewall is running
sudo ufw status

# Should show: Status: active

# If inactive, enable it
sudo ufw enable

# View firewall rules
sudo ufw status numbered

# Check firewall logs
sudo journalctl -u ufw --since today
```

**Firewall should ALWAYS be active!**

---

### Browser Security (LibreWolf)

**LibreWolf is already privacy-focused, but:**

```bash
# Clear browsing data regularly
# LibreWolf → Settings → Privacy & Security → Clear Data

# Check for LibreWolf updates
yay -Syu librewolf

# Use HTTPS everywhere (built into LibreWolf)
# Check for lock icon 🔒 in address bar
```

**Good habits:**
- ✅ Clear cookies weekly
- ✅ Use different passwords for each site
- ✅ Enable 2FA where possible
- ✅ Don't save passwords in browser (use password manager)

---

### Password Management

```bash
# Install a password manager (recommended)
sudo pacman -S keepassxc      # Open-source, local storage

# Or use online option
yay -S bitwarden              # Cloud-based
```

**Never reuse passwords!**

---

## 🧹 SYSTEM CLEANUP (Weekly/Monthly)

### Clean Package Cache

```bash
# Arch keeps old package versions - they pile up!

# See cache size
du -sh /var/cache/pacman/pkg/

# Clean old packages (keep last 3 versions)
sudo pacman -Sc

# Remove ALL cached packages (aggressive)
sudo pacman -Scc

# Automated cleanup with paccache
sudo pacman -S pacman-contrib
sudo paccache -r              # Keep last 3 versions
sudo paccache -rk 1           # Keep only 1 version
```

**Recommendation:** Run `sudo paccache -r` monthly

---

### Remove Orphaned Packages

```bash
# List orphaned packages (not needed by anything)
pacman -Qtdq

# Remove them
sudo pacman -Rns $(pacman -Qtdq)

# If it says "no targets", you're clean!
```

**Run this:** After removing packages or monthly

---

### Clean Home Directory

```bash
# Find large files
du -sh ~/.cache/*             # Browser/app caches
du -sh ~/Downloads/*          # Old downloads

# Clean browser cache
rm -rf ~/.cache/librewolf/*   # LibreWolf cache
rm -rf ~/.cache/mozilla/*     # Firefox cache

# Clean package manager cache
rm -rf ~/.cache/yay/*

# Find big files in home directory
du -ah ~ | sort -rh | head -20
```

**Recommendation:** Clean caches monthly

---

### Check Disk Space

```bash
# Overall disk usage
df -h

# Should see something like:
# /dev/sda3    108G   15G   88G   15% /

# If usage > 80%, clean up!

# Find what's using space
ncdu                          # Interactive disk usage
sudo pacman -S ncdu           # Install if needed

# Or simple version
du -sh /* 2>/dev/null | sort -rh | head -10
```

---

## 🔍 SYSTEM HEALTH CHECKS

### Check for Failed Services

```bash
# List failed services
systemctl --failed

# Should be empty or minimal

# Check specific service
systemctl status NetworkManager
systemctl status ufw

# View recent errors
journalctl -p 3 -xb           # Priority 3 = errors
```

**Run this:** Weekly

---

### Monitor System Resources

```bash
# Install monitoring tools
sudo pacman -S htop

# CPU, RAM, processes
htop

# Quick resource check
free -h                       # RAM usage
df -h                         # Disk usage

# Check which processes using most resources
ps aux --sort=-%mem | head   # Memory hogs
ps aux --sort=-%cpu | head   # CPU hogs
```

---

### Check System Logs

```bash
# Recent errors
journalctl -p 3 -xb

# Today's logs
journalctl --since today

# Last boot logs
journalctl -b

# Follow logs in real-time
journalctl -f

# Specific service logs
journalctl -u NetworkManager
journalctl -u ufw
```

**Check logs:** When something seems wrong

---

### Temperature Monitoring

```bash
# Install sensors
sudo pacman -S lm_sensors

# Detect sensors
sudo sensors-detect          # Say YES to all

# Check temperatures
sensors

# Should show CPU temp (safe: <80°C, warning: >90°C)
```

**MacBook Air typically:**
- 🟢 Idle: 40-50°C
- 🟡 Normal use: 50-70°C  
- 🔴 Heavy load: 70-90°C
- ⚠️ Throttling: >90°C

---

## 💾 BACKUPS (CRITICAL!)

### What to Backup

```bash
# Important directories
~/.config/                    # App configurations
~/.local/share/              # App data
~/Documents/                 # Your files
~/Projects/                  # Code projects
~/.ssh/                      # SSH keys (if you use)
~/.gnupg/                    # GPG keys (if you use)

# System configs (optional)
/etc/
```

---

### Backup Methods

**Method 1: USB Drive Backup (Simple)**

```bash
# Plug in USB drive
lsblk                        # Find USB device (e.g., sdb1)

# Mount USB
sudo mkdir -p /mnt/usb
sudo mount /dev/sdb1 /mnt/usb

# Copy files
rsync -av --progress ~/Documents/ /mnt/usb/backup/Documents/
rsync -av --progress ~/.config/ /mnt/usb/backup/.config/

# Unmount
sudo umount /mnt/usb
```

---

**Method 2: Automated Backup with rsync**

```bash
# Create backup script
nano ~/backup.sh
```

**Add this:**
```bash
#!/bin/bash
BACKUP_DIR="/mnt/usb/backup"
DATE=$(date +%Y%m%d)

rsync -av --delete ~/Documents/ "$BACKUP_DIR/Documents/"
rsync -av --delete ~/.config/ "$BACKUP_DIR/.config/"
rsync -av --delete ~/Projects/ "$BACKUP_DIR/Projects/"

echo "Backup completed: $DATE"
```

**Make executable:**
```bash
chmod +x ~/backup.sh
```

**Run it:**
```bash
# Mount USB first
sudo mount /dev/sdb1 /mnt/usb

# Run backup
~/backup.sh

# Unmount
sudo umount /mnt/usb
```

---

**Method 3: Cloud Backup**

```bash
# Install rclone (supports Google Drive, Dropbox, etc.)
sudo pacman -S rclone

# Configure cloud storage
rclone config

# Sync to cloud
rclone sync ~/Documents/ gdrive:Documents/
rclone sync ~/.config/ gdrive:Config/
```

---

### Backup Schedule

**Recommended:**
- 📁 **Documents:** Daily or when you make changes
- ⚙️ **Configs:** Weekly
- 💻 **Full system:** Monthly or before major updates

---

## 🛡️ SYSTEM HARDENING

### SSH Security (if you use SSH)

```bash
# If you use SSH, secure it:
sudo nano /etc/ssh/sshd_config
```

**Recommended settings:**
```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
Port 2222                     # Change from default 22
```

---

### Auto-lock Screen

**Settings → Screensaver**

- ✅ Enable screensaver
- ✅ Lock screen after: 5 minutes
- ✅ Require password to unlock

---

### Disable Unused Services

```bash
# List running services
systemctl list-units --type=service --state=running

# Disable unused ones (be careful!)
sudo systemctl disable bluetooth    # If you don't use Bluetooth
sudo systemctl disable cups          # If you don't print
```

**Don't disable:** NetworkManager, ufw, systemd services

---

## 🚀 PERFORMANCE OPTIMIZATION

### Reduce Startup Time

```bash
# Check boot time
systemd-analyze

# List slow services at boot
systemd-analyze blame

# Disable slow/unused services
sudo systemctl disable NetworkManager-wait-online.service
```

---

### Memory Optimization

```bash
# Check memory usage
free -h

# If low on RAM, check swap usage
swapon --show

# Clear cache (safe - regenerates automatically)
sudo sync && sudo sysctl -w vm.drop_caches=3
```

---

### SSD Optimization (MacBook has SSD)

```bash
# Enable TRIM for SSD
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Check TRIM status
sudo systemctl status fstrim.timer

# Manual TRIM (optional)
sudo fstrim -v /
```

**Run weekly automatically (already set up)**

---

## 📋 WEEKLY CHECKLIST

**Copy this and check off weekly:**

```
[ ] Update system: yay -Syu
[ ] Check disk space: df -h
[ ] Remove orphans: sudo pacman -Rns $(pacman -Qtdq)
[ ] Check failed services: systemctl --failed
[ ] Clear browser cache
[ ] Backup important files
[ ] Check system logs for errors: journalctl -p 3 -xb
[ ] Verify firewall active: sudo ufw status
```

---

## 📋 MONTHLY CHECKLIST

```
[ ] Clean package cache: sudo paccache -r
[ ] Full system backup
[ ] Check SSD health: sudo smartctl -a /dev/sda (install smartmontools)
[ ] Review installed packages: pacman -Qe
[ ] Update AUR packages: yay -Syu
[ ] Check system temperature: sensors
[ ] Review security settings
[ ] Clear old downloads: ~/Downloads/
```

---

## 🆘 TROUBLESHOOTING QUICK FIXES

### Internet Not Working
```bash
# 1. Restart NetworkManager
sudo systemctl restart NetworkManager

# 2. Reconnect WiFi
nmcli connection down "YOUR-WIFI"
nmcli connection up "YOUR-WIFI"

# 3. Check DNS
cat /etc/resolv.conf

# 4. Reboot (last resort)
sudo reboot
```

---

### System Running Slow
```bash
# Check what's using resources
htop

# Check disk usage
df -h

# Clear cache
sudo pacman -Sc
rm -rf ~/.cache/*

# Restart
sudo reboot
```

---

### Audio Not Working
```bash
# Unmute and increase volume
alsamixer

# Restart PulseAudio
pulseaudio -k
pulseaudio --start

# Check audio isn't suspended
pactl list sinks short
pactl suspend-sink 0 0
```

---

### Package Installation Fails
```bash
# Update package database
sudo pacman -Sy

# Fix broken dependencies
sudo pacman -S --needed base-devel

# Clear cache and retry
yay -Sc
yay -S package-name
```

---

### System Won't Boot (Emergency)

**Boot from USB, then:**
```bash
# Mount your system
sudo mount /dev/sda3 /mnt
sudo mount /dev/sda1 /mnt/boot
sudo arch-chroot /mnt

# Fix broken update
pacman -Syu

# Rebuild kernel
mkinitcpio -P

# Fix GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Exit and reboot
exit
sudo reboot
```

---

## 🔧 USEFUL ALIASES FOR ~/.bashrc

**Add these to make maintenance easier:**

```bash
# Edit ~/.bashrc
nano ~/.bashrc

# Add at the end:

# System maintenance
alias update='yay -Syu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq) && sudo paccache -r'
alias orphans='pacman -Qtdq'
alias cache-size='du -sh /var/cache/pacman/pkg/'
alias disk-usage='df -h'
alias check-failed='systemctl --failed'

# Quick info
alias sysinfo='neofetch'
alias temp='sensors'
alias mem='free -h'
alias disk='df -h'

# Logs
alias errors='journalctl -p 3 -xb'
alias logs-today='journalctl --since today'

# Safety
alias rm='rm -i'            # Ask before deleting
alias mv='mv -i'            # Ask before overwriting
alias cp='cp -i'            # Ask before overwriting

# Reload aliases
source ~/.bashrc
```

**Then reload:**
```bash
source ~/.bashrc
```

---

## 📚 HELPFUL COMMANDS REFERENCE

### Package Management
```bash
# Search for package
yay -Ss package-name
pacman -Ss package-name

# Install package
yay -S package-name
sudo pacman -S package-name

# Remove package
sudo pacman -R package-name
sudo pacman -Rs package-name      # With dependencies
sudo pacman -Rns package-name     # With dependencies + config

# List installed packages
pacman -Q                          # All packages
pacman -Qe                         # Explicitly installed
pacman -Qm                         # AUR packages only

# Package info
pacman -Qi package-name           # Installed package
pacman -Si package-name           # Available package

# Which package owns file?
pacman -Qo /usr/bin/firefox
```

---

### System Info
```bash
# System information
neofetch                          # Pretty system info
uname -r                          # Kernel version
hostnamectl                       # Hostname, OS info
lscpu                             # CPU info
lsblk                             # Block devices
free -h                           # Memory usage
df -h                             # Disk usage
uptime                            # System uptime
```

---

### Process Management
```bash
# List processes
ps aux                            # All processes
ps aux | grep firefox            # Find specific process

# Kill process
killall firefox                   # Kill by name
kill -9 PID                       # Force kill by PID

# Monitor processes
htop                              # Interactive
top                               # Basic version
```

---

## 🎯 ESSENTIAL PACKAGES TO KEEP INSTALLED

**Don't remove these!**

```bash
# Core system
base linux linux-firmware grub

# Network
networkmanager nm-connection-editor network-manager-applet

# Desktop
xfce4 xfce4-goodies xorg-server sddm

# Audio
pulseaudio alsa-utils pavucontrol

# Security
ufw librewolf

# Tools
git wget curl htop nano vim
```

---

## ⚠️ WHAT NOT TO DO

**Avoid these common mistakes:**

❌ **Don't run as root** - Use sudo when needed, not `su`
❌ **Don't install random AUR packages** - Check PKGBUILDs first
❌ **Don't skip updates for weeks** - Security risk!
❌ **Don't ignore disk space warnings** - Keep 20% free
❌ **Don't edit system files without backup** - Copy first!
❌ **Don't disable firewall** - Keep ufw enabled
❌ **Don't use weak passwords** - Use strong, unique ones
❌ **Don't run unknown scripts** - Read them first!
❌ **Don't force-remove dependencies** - Can break system
❌ **Don't forget backups** - You'll regret it!

---

## 📖 LEARNING RESOURCES

**Official Documentation:**
- Arch Wiki: https://wiki.archlinux.org/
- Best Linux documentation in existence!

**For specific issues:**
- Search: "arch wiki [your problem]"
- Example: "arch wiki wifi issues"

**Community:**
- r/archlinux on Reddit
- Arch Linux Forums

**Security:**
- ProtonVPN blog (VPN/privacy tips)
- PrivacyGuides.org

---

## 🎓 GROWING YOUR SKILLS

**As you get comfortable:**

```bash
# Learn shell scripting
nano ~/myscript.sh

# Learn git
sudo pacman -S git
git config --global user.name "Your Name"

# Customize your system
nano ~/.bashrc
nano ~/.xinitrc

# Try new desktop environments
# But wait until you're comfortable!
```

---

## 📝 QUICK DAILY ROUTINE

**Morning (2 minutes):**
```bash
# Check for updates
yay -Qu

# If updates available, install them
yay -Syu

# Check system health
systemctl --failed
df -h
```

**Evening (1 minute):**
```bash
# Backup important work
rsync -av ~/Documents/ /mnt/usb/backup/

# Clear browser cache (weekly)
# LibreWolf → Settings → Clear Data
```

**Weekly (5 minutes):**
```bash
# Full update
yay -Syu

# Clean up
sudo pacman -Rns $(pacman -Qtdq)
sudo paccache -r

# Check logs
journalctl -p 3 -xb
```

---

## 🔐 FINAL SECURITY CHECKLIST

**Your system is secure if:**

✅ Firewall is enabled: `sudo ufw status`
✅ System is updated regularly: `yay -Syu`
✅ VPN works when needed: `vpn-on`
✅ Strong passwords everywhere
✅ Backups are regular
✅ Disk encryption (if you set it up during install)
✅ Screen auto-locks after 5 minutes
✅ No unnecessary services running
✅ LibreWolf is your browser (privacy-focused)

---

**Save this file for reference:**

```bash
cp /mnt/user-data/outputs/arch-maintenance-cheatsheet.md ~/maintenance.md
```

**View anytime:**
```bash
cat ~/maintenance.md | less
```

**Print weekly checklist:**
```bash
grep "\[ \]" ~/maintenance.md
```

---

**You now have a solid, secure Arch Linux system! 🎉**

**Remember:** 
- Update weekly
- Backup important files
- Keep firewall on
- Use VPN for sensitive tasks
- Don't panic - Arch Wiki has answers!

**Welcome to the Arch Linux community!** 🚀