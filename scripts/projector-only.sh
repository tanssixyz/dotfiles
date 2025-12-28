#!/bin/bash
xrandr --output eDP-1 --off --output HDMI-1 --auto
pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo
notify-send "Display" "Projector only + HDMI audio"
