#!/bin/bash

# Get Bluetooth status
STATUS=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')
CONNECTED=$(bluetoothctl info | grep "Device" | wc -l)

if [ "$STATUS" == "yes" ]; then
    if [ "$CONNECTED" -gt 0 ]; then
        echo "Bluetooth: $CONNECTED device(s)"
    else
        echo "Bluetooth: On (No devices connected)"
    fi
else
    echo "Bluetooth: Off"
fi

# Handle click events
case $BLOCK_BUTTON in
    1) bluetoothctl power on ;;  # Left click: Turn on Bluetooth
    2) bluetoothctl power off ;; # Middle click: Turn off Bluetooth
    3) bluetoothctl devices | rofi -dmenu | awk '{print $2}' | xargs bluetoothctl connect ;; # Right click: Connect to a device
esac
