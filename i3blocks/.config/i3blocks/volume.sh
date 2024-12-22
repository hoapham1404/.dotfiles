#!/bin/bash

# Handle click events
case $BLOCK_BUTTON in
    1) amixer set Master toggle ;;  # Left click: Toggle mute
    4) amixer set Master 5%+ ;;     # Scroll up: Increase volume
    5) amixer set Master 5%- ;;     # Scroll down: Decrease volume
esac

# Get volume and mute status
VOLUME=$(amixer get Master | grep -oP '\d+%' | head -1)
MUTED=$(amixer get Master | grep -oP '\[on\]|\[off\]' | head -1)

# Format output
if [ "$MUTED" == "[off]" ]; then
    echo "Muted $VOLUME"
else
    echo "Volume $VOLUME"
fi

