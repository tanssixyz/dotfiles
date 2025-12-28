#!/bin/bash
# Set projector to its native resolution
xrandr --output HDMI-1 --auto --scale-from 1440x900 --output eDP-1 --auto
pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo
notify-send "Display" "Mirror mode + HDMI audio"

