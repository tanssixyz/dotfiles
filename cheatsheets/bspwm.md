# bspwm Cheatsheet

## Core Concepts

**Node** - Any window or container in the tree
**Desktop** - Virtual workspace (like 1-10)
**Monitor** - Physical screen
**Receptacle** - Placeholder for a window (advanced)

## Tree Structure

```
Monitor
├── Desktop 1
│   ├── Node (window)
│   └── Node (window)
├── Desktop 2
│   └── Node (window)
```

---

## Default Keybindings (sxhkd)

### Window Management

| Key | Action |
|-----|--------|
| `Super + Enter` | Open terminal |
| `Super + q` | Close window |
| `Super + Shift + q` | Kill window |
| `Super + t` | Tiled mode |
| `Super + Shift + t` | Pseudo-tiled |
| `Super + s` | Floating mode |
| `Super + f` | Fullscreen |
| `Super + m` | Monocle mode (single window) |

### Navigation

| Key | Action |
|-----|--------|
| `Super + h/j/k/l` | Focus window (left/down/up/right) |
| `Super + Shift + h/j/k/l` | Move window |
| `Super + Alt + h/j/k/l` | Resize window |
| `Super + Tab` | Focus last window |
| `Super + {1-9,0}` | Switch to desktop |
| `Super + Shift + {1-9,0}` | Move window to desktop |

### Window States

| Key | Action |
|-----|--------|
| `Super + Ctrl + m` | Toggle monocle layout |
| `Super + y` | Mark window (newest) |
| `Super + u` | Mark window (urgent) |

---

## Common bspc Commands

### Query Information

```bash
# List all desktops
bspc query -D --names

# List windows on current desktop
bspc query -N -d focused

# Check current desktop
bspc query -D -d focused --names

# List all monitors
bspc query -M --names
```

### Window Manipulation

```bash
# Close focused window
bspc node -c

# Kill focused window
bspc node -k

# Toggle floating
bspc node -t floating

# Toggle fullscreen
bspc node -t fullscreen

# Send window to desktop 5
bspc node -d 5

# Swap with biggest window
bspc node -s biggest.local
```

### Desktop Management

```bash
# Add new desktop
bspc monitor -a temp

# Remove empty desktop
bspc desktop temp -r

# Rename desktop
bspc desktop -n new_name

# Focus next/previous desktop
bspc desktop -f next
bspc desktop -f prev
```

### Layout Control

```bash
# Rotate tree 90 degrees
bspc node @/ -R 90

# Balance tree (equalize window sizes)
bspc node @/ -B

# Flip tree horizontally
bspc node @/ -F horizontal

# Flip tree vertically
bspc node @/ -F vertical
```

### Gaps & Borders

```bash
# Set window gap to 10px
bspc config window_gap 10

# Set border width
bspc config border_width 2

# Remove gaps on current desktop
bspc config -d focused window_gap 0
```

---

## Configuration Files

### ~/.config/bspwm/bspwmrc
```bash
#!/bin/sh

# Monitors and desktops
bspc monitor -d 1 2 3 4 5 6 7 8 9 10

# Window settings
bspc config border_width         2
bspc config window_gap          12
bspc config split_ratio          0.52
bspc config borderless_monocle   true
bspc config gapless_monocle      true

# Focus settings
bspc config focus_follows_pointer true
bspc config pointer_follows_focus false

# Colors
bspc config normal_border_color   "#44475a"
bspc config active_border_color   "#bd93f9"
bspc config focused_border_color  "#ff79c6"

# Rules
bspc rule -a Firefox desktop='^2' follow=on
bspc rule -a mpv state=floating
bspc rule -a Zathura state=tiled
```

### ~/.config/sxhkd/sxhkdrc
```bash
# Terminal
super + Return
    kitty

# Program launcher
super + d
    rofi -show drun

# Reload sxhkd
super + Escape
    pkill -USR1 -x sxhkd

# Quit/restart bspwm
super + shift + {e,r}
    bspc {quit,wm -r}

# Close/kill
super + {_,shift + }q
    bspc node -{c,k}

# Window states
super + {t,shift + t,s,f}
    bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

# Focus/move window
super + {_,shift + }{h,j,k,l}
    bspc node -{f,s} {west,south,north,east}

# Focus/send to desktop
super + {_,shift + }{1-9,0}
    bspc {desktop -f,node -d} '^{1-9,10}'

# Resize window
super + alt + {h,j,k,l}
    bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}
```

---

## Useful Rules

```bash
# Floating windows
bspc rule -a feh state=floating
bspc rule -a mpv state=floating

# Specific desktop
bspc rule -a Firefox desktop='^2'
bspc rule -a spotify desktop='^10'

# Sticky (appears on all desktops)
bspc rule -a scratchpad sticky=on state=floating

# Center floating window
bspc rule -a Pavucontrol state=floating center=true
```

---

## Troubleshooting

```bash
# Restart bspwm (keeps windows open)
bspc wm -r

# Reload sxhkd
pkill -USR1 -x sxhkd

# Check if sxhkd is running
ps aux | grep sxhkd

# Test keybinding
bspc node -c  # Should close focused window

# View current rules
bspc rule -l

# Remove all rules
bspc rule -r '*'
```

---

## Tips

1. **Monocle mode** (`Super + m`) is great for focused work - hides all but one window
2. **Balance tree** with `bspc node @/ -B` when windows look uneven
3. **Use receptacles** for precise layouts (advanced)
4. **Focus follows pointer** can be toggled in bspwmrc
5. **Preselect** splits with `bspc node -p {north,south,east,west}` before opening a window

---

## Node Selectors

```bash
focused      # Currently focused node
biggest      # Biggest node
newest       # Most recently created
oldest       # Least recently created
pointed      # Under the pointer
@/           # Root node (entire desktop)
@parent      # Parent of focused
@brother     # Sibling of focused
```

---

## Quick Reference Card

```
BASICS               LAYOUT              RESIZE
h/j/k/l  Navigate    Shift+t  Pseudo     Alt+h/j/k/l  Resize
Shift+h/j/k/l Move   t        Tiled      @/ -R 90     Rotate
q        Close       s        Float      @/ -B        Balance  
Shift+q  Kill        f        Full       @/ -F h/v    Flip
1-0      Desktop     m        Monocle
Shift+1-0 Move to
```
