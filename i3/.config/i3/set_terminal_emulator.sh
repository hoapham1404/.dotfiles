#!/bin/bash

# Check for terminal availability
if command -v wezterm &> /dev/null; then
    TERMINAL="wezterm"
elif command -v  &> /dev/null; then
    TERMINAL="kitty"
else
    TERMINAL="x-terminal-emulator"
fi

# Execute the terminal
exec $TERMINAL
