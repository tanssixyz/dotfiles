#!/bin/bash

# Check if trackpad is enabled
if xinput list-props 11 | grep "Device Enabled" | grep -q "1$"; then
    # Disable it
    xinput disable 11
    notify-send "Trackpad" "Disabled"
else
    # Enable it
    xinput enable 11
    notify-send "Trackpad" "Enabled"
fi#!/bin/bash

# Check if trackpad is enabled
if xinput list-props 11 | grep "Device Enabled" | grep -q "1$"; then
    # Disable it
    xinput disable 11
    notify-send "Trackpad" "Disabled"
else
    # Enable it
    xinput enable 11
    notify-send "Trackpad" "Enabled"
fi
