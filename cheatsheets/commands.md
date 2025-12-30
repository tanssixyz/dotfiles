# Linux, Nvim & Tmux Cheatsheet

## PART 1: ESSENTIAL LINUX COMMANDS

### Navigation

```bash
pwd                 # Print working directory
ls                  # List files
ls -la              # List all files with details (including hidden)
ls -lh              # List with human-readable sizes
cd /path/to/dir     # Change directory
cd ..               # Go up one level
cd ~                # Go to home directory
cd -                # Go to previous directory
```

### File Viewing

```bash
cat file.txt        # Display entire file
less file.txt       # View file with scrolling (q to quit)
head file.txt       # Show first 10 lines
head -n 20 file.txt # Show first 20 lines
tail file.txt       # Show last 10 lines
tail -f log.txt     # Follow file updates in real-time
```

### Creating Files and Directories

```bash
touch file.txt              # Create empty file
mkdir directory             # Create directory
mkdir -p path/to/nested     # Create nested directories
echo "text" > file.txt      # Create file with content (overwrites)
echo "text" >> file.txt     # Append to file
```

### Copying, Moving, Deleting

```bash
cp source.txt dest.txt      # Copy file
cp -r source_dir dest_dir   # Copy directory recursively
mv old.txt new.txt          # Rename file
mv file.txt /path/to/       # Move file
rm file.txt                 # Remove file
rm -r directory             # Remove directory recursively
rm -rf directory            # Force remove (DANGEROUS!)
rmdir empty_dir             # Remove empty directory only
```

### Searching

```bash
find . -name "*.txt"        # Find files by name
find . -type f -name "*.log" # Find only files
grep "search" file.txt      # Search inside file
grep -r "search" .          # Search recursively
grep -i "search" file.txt   # Case-insensitive search
grep -n "search" file.txt   # Show line numbers
```

### File Information

```bash
file filename       # Determine file type
stat filename       # Detailed file info
wc file.txt         # Count lines, words, characters
wc -l file.txt      # Count lines only
du -sh *            # Size of files/folders
df -h               # Disk space usage
```

### Permissions

```bash
ls -l               # View permissions
chmod +x script.sh  # Make executable
chmod 644 file.txt  # Set permissions (rw-r--r--)
chmod 755 script.sh # Common for executables (rwxr-xr-x)
chown user:group file # Change owner
```

**Permission numbers:**

- 7 = rwx (read, write, execute)
- 6 = rw- (read, write)
- 5 = r-x (read, execute)
- 4 = r-- (read only)

### Archives

```bash
tar -czf archive.tar.gz folder/  # Create compressed archive
tar -xzf archive.tar.gz           # Extract archive
tar -tzf archive.tar.gz           # List contents
zip -r archive.zip folder/        # Create zip
unzip archive.zip                 # Extract zip
```

### System Information

```bash
uname -a            # System info
uptime              # How long system running
date                # Current date/time
whoami              # Current username
hostname            # Computer name
```

### Battery Status

```bash
acpi -b             # Battery info (install: sudo pacman -S acpi)
cat /sys/class/power_supply/BAT0/capacity  # Battery percentage
cat /sys/class/power_supply/BAT0/status    # Charging status
```

### Process Management

```bash
ps aux              # List all processes
ps aux | grep name  # Find specific process
top                 # Interactive process viewer (q to quit)
htop                # Better viewer (sudo pacman -S htop)
kill PID            # Kill process by ID
kill -9 PID         # Force kill
killall name        # Kill all by name
```

### Package Management (Arch/pacman)

```bash
sudo pacman -S package   # Install package
sudo pacman -R package   # Remove package
sudo pacman -Syu         # Update system
pacman -Ss search        # Search packages
pacman -Qi package       # Show package info
```

### Pipes and Redirection

```bash
command > file.txt       # Redirect output (overwrites)
command >> file.txt      # Append output
command 2> errors.txt    # Redirect errors
command1 | command2      # Pipe output to next command
cat file | grep "text"   # Chain commands
```

### Keyboard Shortcuts (Bash)

```bash
Ctrl+C              # Cancel current command
Ctrl+D              # Exit shell / EOF
Ctrl+L              # Clear screen (or type: clear)
Ctrl+A              # Move to beginning of line
Ctrl+E              # Move to end of line
Ctrl+U              # Clear line before cursor
Ctrl+K              # Clear line after cursor
Ctrl+W              # Delete word before cursor
Ctrl+R              # Search command history
Tab                 # Auto-complete
!!                  # Repeat last command
sudo !!             # Run last command with sudo
```

---

## PART 2: NVIM COPY/PASTE & EDITING

### Modes

```
i                   # Insert mode (before cursor)
I                   # Insert at beginning of line
a                   # Append (after cursor)
A                   # Append at end of line
o                   # Open new line below
O                   # Open new line above
Esc or Ctrl+[       # Return to normal mode
v                   # Visual mode (character selection)
V                   # Visual line mode
Ctrl+v              # Visual block mode
```

### Basic Movement

```
h j k l             # Left, down, up, right
w                   # Next word
b                   # Previous word
e                   # End of word
0                   # Start of line
^                   # First non-blank character
$                   # End of line
gg                  # Start of file
G                   # End of file
5G or :5            # Go to line 5
Ctrl+u              # Page up
Ctrl+d              # Page down
```

### Copying (Yanking)

```
yy                  # Copy current line
5yy                 # Copy 5 lines
y$                  # Copy from cursor to end of line
y^                  # Copy from cursor to start of line
yiw                 # Copy word under cursor
yaw                 # Copy word with surrounding space
yap                 # Copy paragraph
gg"+yG              # Copy entire file to system clipboard
```

### Visual Selection + Copy

```
v                   # Enter visual mode
V                   # Enter visual line mode
Ctrl+v              # Enter visual block mode
(move cursor to select)
y                   # Copy selection
"+y                 # Copy to system clipboard
d                   # Cut selection
```

### Pasting

```
p                   # Paste after cursor/line
P                   # Paste before cursor/line
"+p                 # Paste from system clipboard
"0p                 # Paste from yank register (not affected by delete)
```

### System Clipboard (Between Files/Apps)

```
"+y                 # Copy to system clipboard
"+p                 # Paste from system clipboard
"+Y                 # Copy line to system clipboard
```

### Named Registers (Multiple Clipboards)

```
"ay                 # Copy to register 'a'
"ap                 # Paste from register 'a'
"by                 # Copy to register 'b'
"bp                 # Paste from register 'b'
:reg                # View all registers
```

### Deleting (Cut)

```
dd                  # Delete (cut) line
5dd                 # Delete 5 lines
dw                  # Delete word
d$                  # Delete to end of line
diw                 # Delete word under cursor
dap                 # Delete paragraph
x                   # Delete character
```

### Undo/Redo

```
u                   # Undo
Ctrl+r              # Redo
.                   # Repeat last change
```

### File Operations

```
:w                  # Save
:w filename         # Save as
:q                  # Quit
:q!                 # Quit without saving
:wq or :x or ZZ     # Save and quit
:e filename         # Open file
:e!                 # Reload file (discard changes)
```

### Multiple Files

```
:e file2.txt        # Open another file
:split file.txt     # Horizontal split
:vsplit file.txt    # Vertical split
Ctrl+w w            # Cycle through windows
Ctrl+w h/j/k/l      # Move to window (left/down/up/right)
Ctrl+w q            # Close current window
Ctrl+w =            # Make windows equal size
```

### Buffers

```
:ls or :buffers     # List all buffers
:b2                 # Switch to buffer 2
:bn                 # Next buffer
:bp                 # Previous buffer
:bd                 # Delete buffer (close file)
```

### Search and Replace

```
/pattern            # Search forward
?pattern            # Search backward
n                   # Next match
N                   # Previous match
:%s/old/new/g       # Replace all in file
:%s/old/new/gc      # Replace with confirmation
:noh                # Clear search highlighting
```

### Useful Commands

```
:set number         # Show line numbers
:set nonumber       # Hide line numbers
:set paste          # Paste mode (prevents auto-indent)
:set nopaste        # Normal mode
ggVG                # Select entire file
=                   # Auto-indent selected lines
gg=G                # Auto-indent entire file
```

---

## PART 3: TMUX SHORTCUTS

**Note:** Default prefix is `Ctrl+b` (shown as `Prefix` below)

### Session Management

```bash
tmux                        # Start new session
tmux new -s name            # Start named session
tmux ls                     # List sessions
tmux attach                 # Attach to last session
tmux attach -t name         # Attach to named session
tmux kill-session -t name   # Kill session
```

**Inside tmux:**

```
Prefix d                # Detach from session
Prefix $                # Rename session
Prefix s                # List sessions (switch)
Prefix (                # Previous session
Prefix )                # Next session
```

### Window Management

```
Prefix c                # Create new window
Prefix ,                # Rename current window
Prefix w                # List windows
Prefix n                # Next window
Prefix p                # Previous window
Prefix 0-9              # Switch to window number
Prefix &                # Kill current window
Prefix f                # Find window
```

### Pane Management (Splits)

```
Prefix %                # Vertical split
Prefix "                # Horizontal split
Prefix o                # Cycle through panes
Prefix ;                # Toggle last active pane
Prefix arrow            # Move to pane (arrow keys)
Prefix x                # Kill current pane
Prefix z                # Toggle pane zoom (fullscreen)
Prefix {                # Move pane left
Prefix }                # Move pane right
Prefix Ctrl+arrow       # Resize pane
Prefix Alt+arrow        # Resize pane (smaller increments)
Prefix !                # Break pane into window
Prefix q                # Show pane numbers
Prefix space            # Toggle pane layouts
```

### Copy Mode (Scrolling/Copying)

```
Prefix [                # Enter copy mode
q                       # Exit copy mode
Ctrl+u / Ctrl+d         # Page up / down
gg                      # Go to top
G                       # Go to bottom
/                       # Search forward
?                       # Search backward
n                       # Next search result
Space                   # Start selection
Enter                   # Copy selection
Prefix ]                # Paste
```

### Tmux Copy/Paste (Vi Mode)

**Enable vi mode in ~/.tmux.conf:**

```bash
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
```

**Then in copy mode:**

```
v                       # Begin selection (visual)
y                       # Copy selection
Prefix ]                # Paste
```

### Useful Commands

```
Prefix :                # Command prompt
Prefix ?                # List all keybindings
Prefix t                # Show time
Prefix r                # Reload config (:source-file ~/.tmux.conf)
```

### Tmux Configuration Tips

Add to `~/.tmux.conf`:

```bash
# Easier prefix (Ctrl+a instead of Ctrl+b)
set-option -g prefix C-a
unbind C-b
bind C-a send-prefix

# Split panes using | and -
bind | split-window -h
bind - split-window -v

# Switch panes using Alt+arrow (no prefix needed)
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Enable mouse mode
set -g mouse on

# Vi mode
set-window-option -g mode-keys vi

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Reload config
bind r source-file ~/.tmux.conf \; display "Config reloaded!"
```

---

## WORKFLOW: COPY/PASTE BETWEEN NVIM AND TMUX

### Within same nvim instance:

1. Select text: `V` or `v`
2. Copy: `y`
3. Open another file: `:e file2.txt` or `:split file2.txt`
4. Paste: `p`

### Between different nvim instances (using system clipboard):

**In first nvim:**

1. Select: `V`
2. Copy to clipboard: `"+y`

**In second nvim (different tmux pane/window):** 3. Paste from clipboard: `"+p`

### Using tmux copy mode to copy terminal output:

1. `Prefix [` (enter copy mode)
2. Navigate with arrow keys or vi keys
3. `Space` to start selection
4. Move to select text
5. `Enter` to copy
6. `Prefix ]` to paste in terminal
7. Or in nvim: `"+p` if you have tmux-clipboard integration

### Quick file editing across tmux panes:

```bash
# In one pane
nvim file1.txt

# Create vertical split in tmux
Prefix %

# In new pane
nvim file2.txt

# Copy in file1 with "+y, paste in file2 with "+p
# Or switch between panes: Prefix arrow
```

---

## PRO TIPS

### Essential Aliases (add to ~/.bashrc)

```bash
alias ll='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias battery='echo "Battery: $(cat /sys/class/power_supply/BAT0/capacity)% - $(cat /sys/class/power_supply/BAT0/status)"'
alias update='sudo pacman -Syu'
alias c='clear'
alias h='history'
alias reload='source ~/.bashrc'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git pull'
```

### Learning Strategy

1. **Week 1:** Master basic navigation (cd, ls, pwd) and file operations (cp, mv, rm)
2. **Week 2:** Learn nvim basics (modes, movement, copy/paste)
3. **Week 3:** Get comfortable with tmux (sessions, windows, panes)
4. **Week 4:** Practice integrated workflow (nvim + tmux together)

### Quick Reference

**Most used commands:**

- `ls -la` - see everything
- `cd` - navigate
- `nvim file` - edit
- `"+y` / `"+p` - copy/paste between apps
- `Prefix c` - new tmux window
- `Prefix %` - split tmux pane

**Remember:**

- Use `man command` for help on any command
- Use `Ctrl+R` to search command history
- Use Tab for auto-completion
- Practice daily - muscle memory is key!
