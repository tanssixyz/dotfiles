# Linux Network Command-Line Cheat Sheet
**Arch Linux - NetworkManager Edition**

---

## 📡 NETWORKMANAGER (nmcli) - Main Network Tool

### Basic Status & Info
```bash
# Show all network devices
nmcli device status

# Show all connections (saved networks)
nmcli connection show

# Show only active connections
nmcli connection show --active

# Detailed device info
nmcli device show

# Check if networking is enabled
nmcli networking
```

### WiFi Management
```bash
# Enable/disable WiFi radio
nmcli radio wifi on
nmcli radio wifi off

# Scan for networks
nmcli device wifi rescan

# List available WiFi networks
nmcli device wifi list

# Connect to WiFi (will prompt for password)
nmcli device wifi connect "SSID-NAME"

# Connect with password in command
nmcli device wifi connect "SSID-NAME" password "your-password"

# Disconnect current WiFi
nmcli connection down "YOUR-WIFI-NAME"

# Reconnect
nmcli connection up "YOUR-WIFI-NAME"

# Show WiFi password for saved network
nmcli connection show "YOUR-WIFI-NAME" | grep psk

# Show WiFi password (requires sudo)
sudo nmcli connection show "YOUR-WIFI-NAME" | grep psk
```

### Connection Management
```bash
# Modify connection to auto-connect
nmcli connection modify "CONNECTION-NAME" connection.autoconnect yes

# Prevent auto-connect
nmcli connection modify "CONNECTION-NAME" connection.autoconnect no

# Set connection priority (higher = preferred)
nmcli connection modify "CONNECTION-NAME" connection.autoconnect-priority 10

# Delete a saved connection
nmcli connection delete "CONNECTION-NAME"

# Rename connection
nmcli connection modify "OLD-NAME" connection.id "NEW-NAME"
```

### DNS Management
```bash
# Set manual DNS for connection
nmcli connection modify "CONNECTION-NAME" ipv4.dns "8.8.8.8 1.1.1.1"

# Use automatic DNS (from router/DHCP)
nmcli connection modify "CONNECTION-NAME" ipv4.dns ""
nmcli connection modify "CONNECTION-NAME" ipv4.ignore-auto-dns no

# Add DNS without replacing existing
nmcli connection modify "CONNECTION-NAME" +ipv4.dns "1.1.1.1"

# Apply changes (reconnect)
nmcli connection down "CONNECTION-NAME" && nmcli connection up "CONNECTION-NAME"
```

### IP Address Management
```bash
# Get automatic IP (DHCP)
nmcli connection modify "CONNECTION-NAME" ipv4.method auto

# Set static IP
nmcli connection modify "CONNECTION-NAME" ipv4.addresses "192.168.1.100/24"
nmcli connection modify "CONNECTION-NAME" ipv4.gateway "192.168.1.1"
nmcli connection modify "CONNECTION-NAME" ipv4.method manual

# View current IP address
nmcli -f IP4.ADDRESS device show wlan0
```

---

## 🔒 VPN MANAGEMENT

### VPN Connection Control
```bash
# List all VPN connections
nmcli connection show | grep vpn

# Connect to VPN
nmcli connection up "VPN-NAME"

# Disconnect VPN
nmcli connection down "VPN-NAME"

# Check if VPN is connected
nmcli connection show --active | grep vpn

# Prevent VPN auto-connect on boot
nmcli connection modify "VPN-NAME" connection.autoconnect no

# Enable VPN auto-connect
nmcli connection modify "VPN-NAME" connection.autoconnect yes
```

### VPN Shortcuts (add to ~/.bashrc)
```bash
# Add these aliases to ~/.bashrc
alias vpn-on='nmcli connection up NL-FREE-231 && echo "✅ VPN Connected"'
alias vpn-off='nmcli connection down NL-FREE-231 && echo "❌ VPN Disconnected"'
alias vpn-status='nmcli connection show --active | grep vpn || echo "No VPN connected"'
alias vpn-ip='curl -s ifconfig.me && echo ""'
```

### Check VPN Status
```bash
# Show public IP (should be VPN IP when connected)
curl ifconfig.me
curl ipinfo.io

# Show detailed IP info with location
curl ipinfo.io/json

# Check DNS servers in use
cat /etc/resolv.conf

# Check for DNS leaks
curl -s https://1.1.1.1/cdn-cgi/trace | grep fl=
```

---

## 🔍 NETWORK DIAGNOSTICS

### Basic Connectivity Tests
```bash
# Ping (test connection)
ping google.com                    # Press Ctrl+C to stop
ping -c 4 google.com              # Send 4 packets then stop
ping -c 10 8.8.8.8                # Ping Google DNS directly

# Ping statistics
ping -c 100 google.com | tail -2  # Show packet loss and avg time

# Test if internet is working (one packet)
ping -c 1 -W 2 8.8.8.8 > /dev/null && echo "Internet OK" || echo "No Internet"
```

### DNS Resolution
```bash
# Check DNS resolution
nslookup google.com
nslookup google.com 8.8.8.8       # Use specific DNS server

# Better DNS tool (install if needed: sudo pacman -S bind)
dig google.com
dig google.com @1.1.1.1           # Query Cloudflare DNS
dig google.com +short             # Show only IP address

# Simple hostname lookup
host google.com
host 8.8.8.8                      # Reverse lookup

# Test DNS speed
time dig google.com @8.8.8.8
time dig google.com @1.1.1.1
```

### Trace Network Path
```bash
# Trace route to destination (install: sudo pacman -S traceroute)
traceroute google.com
traceroute -n google.com          # Don't resolve hostnames (faster)

# Better traceroute tool (install: sudo pacman -S mtr)
mtr google.com                    # Real-time, interactive
mtr -n google.com                 # No DNS resolution
mtr -r -c 10 google.com          # Report mode, 10 cycles
```

### Port & Connection Testing
```bash
# Check if port is open (install: sudo pacman -S nmap)
nc -zv google.com 443             # Check if port 443 open
nc -zv 192.168.1.1 22             # Check SSH port

# Scan common ports
nmap localhost                     # Scan your own machine
nmap 192.168.1.1                  # Scan router
nmap -p 80,443 example.com        # Check specific ports

# Show active network connections
ss -tuln                          # All listening TCP/UDP ports
ss -tulpn                         # Include program names (needs sudo)
netstat -tuln                     # Alternative to ss
```

### Download Speed Tests
```bash
# Install speedtest-cli
sudo pacman -S speedtest-cli

# Run speed test
speedtest-cli
speedtest-cli --simple            # Minimal output
speedtest-cli --list             # List nearby servers
speedtest-cli --server 12345      # Use specific server

# Quick download test
wget -O /dev/null http://speedtest.tele2.net/100MB.zip
curl -o /dev/null http://speedtest.tele2.net/10MB.zip
```

---

## 🛡️ FIREWALL (UFW)

### Basic UFW Commands
```bash
# Check firewall status
sudo ufw status
sudo ufw status verbose           # Detailed rules
sudo ufw status numbered          # Show rule numbers

# Enable/disable firewall
sudo ufw enable
sudo ufw disable

# Default policies (already set during install)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Reload firewall
sudo ufw reload
```

### Adding Rules
```bash
# Allow specific port
sudo ufw allow 22                 # SSH
sudo ufw allow 80                 # HTTP
sudo ufw allow 443                # HTTPS

# Allow port range
sudo ufw allow 6000:6007/tcp

# Allow from specific IP
sudo ufw allow from 192.168.1.100

# Allow from subnet
sudo ufw allow from 192.168.1.0/24

# Delete rule by number
sudo ufw status numbered
sudo ufw delete 3                 # Delete rule #3

# Delete rule by specification
sudo ufw delete allow 80
```

### Advanced Firewall
```bash
# Block specific IP
sudo ufw deny from 203.0.113.0

# Allow app through firewall
sudo ufw app list                 # List available apps
sudo ufw allow 'OpenSSH'

# Log firewall activity
sudo ufw logging on
sudo tail -f /var/log/ufw.log    # Watch firewall logs

# Reset firewall to defaults
sudo ufw reset
```

---

## 📊 NETWORK MONITORING

### Real-Time Traffic Monitoring
```bash
# Install monitoring tools
sudo pacman -S iftop nethogs bmon vnstat

# Monitor bandwidth by connection (needs sudo)
sudo iftop                        # ncurses interface
sudo iftop -i wlan0              # Specific interface

# Monitor bandwidth by process
sudo nethogs                      # Which apps using bandwidth
sudo nethogs wlan0               # Specific interface

# Pretty bandwidth monitor
bmon                              # Graph-based monitor

# Track total data usage
vnstat                            # Daily/monthly stats
vnstat -l                         # Live traffic
vnstat -h                         # Hourly stats
vnstat -d                         # Daily stats
```

### Interface Statistics
```bash
# Show interface statistics
ip -s link                        # TX/RX packets, errors

# Detailed interface info
ifconfig                          # Traditional tool
ip addr show                      # Modern tool

# Show routing table
ip route
route -n                          # Alternative

# Show ARP cache (MAC addresses)
ip neighbor
arp -a                            # Alternative
```

### Connection Monitoring
```bash
# Show all active connections
ss -a                             # All sockets
ss -at                            # TCP only
ss -au                            # UDP only
ss -lt                            # Listening TCP
ss -s                             # Statistics summary

# Watch connections in real-time
watch -n 1 'ss -tuln'            # Update every second

# Show established connections
ss -o state established          # With timer info

# Count connections by state
ss -tan | awk '{print $1}' | sort | uniq -c
```

---

## 🌐 HTTP/HTTPS TESTING

### Download Files
```bash
# Download with wget
wget https://example.com/file.zip
wget -c https://example.com/file.zip    # Resume partial download
wget -O output.zip https://example.com/file.zip

# Download with curl
curl -O https://example.com/file.zip    # Keep original filename
curl -o output.zip https://example.com/file.zip
curl -L https://example.com/file.zip    # Follow redirects
```

### HTTP Requests
```bash
# View HTTP headers
curl -I https://example.com
wget --server-response --spider https://example.com

# Test HTTP response time
curl -w "@-" -o /dev/null -s https://example.com << 'EOF'
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
          time_total:  %{time_total}\n
EOF

# Check HTTP status code
curl -o /dev/null -s -w "%{http_code}\n" https://example.com

# POST request
curl -X POST -d "param1=value1" https://example.com/api
```

---

## 🔧 NETWORK CONFIGURATION FILES

### Important Config Files
```bash
# View current DNS servers
cat /etc/resolv.conf

# NetworkManager main config
cat /etc/NetworkManager/NetworkManager.conf
sudo nano /etc/NetworkManager/NetworkManager.conf

# Hosts file (local DNS overrides)
cat /etc/hosts
sudo nano /etc/hosts

# View saved connections
ls /etc/NetworkManager/system-connections/
sudo cat /etc/NetworkManager/system-connections/YOUR-WIFI.nmconnection
```

### System Network Settings
```bash
# View hostname
hostname
hostnamectl

# Change hostname
sudo hostnamectl set-hostname new-hostname

# Network interface names
ls /sys/class/net/
ip link show
```

---

## 🚀 USEFUL NETWORK ALIASES

Add these to **~/.bashrc** for quick access:

```bash
# Edit: nano ~/.bashrc
# Add at the end:

# Network shortcuts
alias netstat-listening='sudo netstat -tlnp'
alias ports='sudo netstat -tulanp'
alias myip='curl ifconfig.me && echo ""'
alias localip='ip addr show | grep "inet " | grep -v 127.0.0.1'
alias speedtest='speedtest-cli'
alias ping='ping -c 5'
alias fastping='ping -c 10 -i 0.2'

# WiFi shortcuts  
alias wifi-on='nmcli radio wifi on'
alias wifi-off='nmcli radio wifi off'
alias wifi-scan='nmcli device wifi rescan && nmcli device wifi list'
alias wifi-list='nmcli connection show'

# VPN shortcuts
alias vpn-on='nmcli connection up NL-FREE-231 && echo "✅ VPN Connected"'
alias vpn-off='nmcli connection down NL-FREE-231 && echo "❌ VPN Disconnected"'
alias vpn-status='nmcli connection show --active | grep vpn || echo "No VPN"'
alias vpn-ip='curl -s ifconfig.me && echo ""'

# DNS shortcuts
alias dns='cat /etc/resolv.conf'
alias dns-check='dig google.com +short'
alias dns-leak='curl -s https://1.1.1.1/cdn-cgi/trace'

# Connection monitoring
alias connections='ss -tuln'
alias listening='ss -tlnp'
alias bandwidth='sudo nethogs'

# Quick diagnostics
alias net-test='ping -c 3 8.8.8.8 && ping -c 3 google.com'
alias net-info='nmcli device show'
```

**Then reload:** `source ~/.bashrc`

---

## 🔍 TROUBLESHOOTING COMMANDS

### When Internet Doesn't Work
```bash
# Step 1: Check if WiFi is enabled
nmcli radio wifi

# Step 2: Check if connected
nmcli connection show --active

# Step 3: Test IP connectivity
ping -c 3 8.8.8.8

# Step 4: Test DNS
ping -c 3 google.com
nslookup google.com

# Step 5: Check DNS config
cat /etc/resolv.conf

# Step 6: Restart NetworkManager
sudo systemctl restart NetworkManager

# Step 7: Reconnect WiFi
nmcli connection down "YOUR-WIFI"
nmcli connection up "YOUR-WIFI"
```

### When VPN Won't Connect
```bash
# Check VPN connection exists
nmcli connection show | grep vpn

# Try connecting with verbose output
nmcli connection up "VPN-NAME" --ask

# Check VPN logs
journalctl -u NetworkManager -f

# Delete and re-import VPN
nmcli connection delete "VPN-NAME"
# Then re-import .ovpn file via nm-connection-editor
```

### Network Reset (Nuclear Option)
```bash
# Stop NetworkManager
sudo systemctl stop NetworkManager

# Restart
sudo systemctl start NetworkManager

# Full reset (careful!)
sudo systemctl restart NetworkManager
sudo systemctl restart systemd-resolved

# If still broken, reboot
sudo reboot
```

---

## 📚 QUICK REFERENCE

### Most Common Commands
```bash
nmcli device status              # Check all network devices
nmcli connection show --active   # What's connected?
ping google.com                  # Test internet
curl ifconfig.me                 # Check public IP
cat /etc/resolv.conf            # Check DNS servers
sudo ufw status                  # Check firewall
speedtest-cli                    # Speed test
sudo nethogs                     # Which apps using internet
```

### Daily Use Commands
```bash
vpn-on                          # Connect VPN (if alias set)
vpn-off                         # Disconnect VPN
myip                            # Show public IP
wifi-scan                       # Scan WiFi networks
net-test                        # Quick connectivity test
```

---

## 🛠️ INSTALLING NETWORK TOOLS

```bash
# Essential tools (probably already installed)
sudo pacman -S networkmanager nm-connection-editor network-manager-applet

# VPN support
sudo pacman -S networkmanager-openvpn

# Diagnostics
sudo pacman -S traceroute mtr nmap bind dnsutils

# Speed testing
sudo pacman -S speedtest-cli

# Monitoring
sudo pacman -S iftop nethogs bmon vnstat

# HTTP tools
sudo pacman -S wget curl

# All at once
sudo pacman -S traceroute mtr nmap bind speedtest-cli iftop nethogs bmon vnstat
```

---

## 📖 LEARNING MORE

```bash
# Get help for any command
man nmcli                       # Full manual
nmcli help                      # Quick help
nmcli connection help           # Subcommand help

# Examples in manual pages
man -k network                  # Search for network commands
```
---

**Save this file to your home directory for quick reference!**

```bash
cp /mnt/user-data/outputs/network-cheatsheet.md ~/network-cheatsheet.md
```

**View anytime with:**
```bash
cat ~/network-cheatsheet.md | less
# Or
nano ~/network-cheatsheet.md
```