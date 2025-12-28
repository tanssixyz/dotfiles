#!/bin/bash
xrandr --output HDMI-1 --off --output eDP-1 --auto
pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
notify-send "Display" "Laptop screen + speakers"
