#!/bin/bash

# Give bspwm a moment to initialize
sleep 2 

# Desktop 1: Claude Code
claude-desktop &

sleep 1

# Desktop 2: kitty with tmux
bspc rule -a kitty -o desktop='^2' && kitty -e tmux &

sleep 1

# Desktop 3: LibreWolf
librewolf &

sleep 1

# Desktop 4: Neomutt
bspc rule -a kitty -o desktop='^4' && kitty -e neomutt &

sleep 2

# Return to desktop 1 (Claude)
bspc desktop -f '^1'




