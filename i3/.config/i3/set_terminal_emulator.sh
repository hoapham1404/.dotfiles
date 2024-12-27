#!/bin/bash

# Check for terminal availability
if command -v kitty &> /dev/null; then
    TERMINAL="kitty"
elif command -v wezterm &> /dev/null; then
    TERMINAL="wezterm"
else
    TERMINAL="x-terminal-emulator"
fi

# Execute the terminal
exec $TERMINAL
