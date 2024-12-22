#!/bin/bash

# Get microphone mute status using `amixer`
MIC_STATUS=$(amixer get Capture | grep -oP '\[on\]|\[off\]' | head -1)

# Format output
if [ "$MIC_STATUS" == "[off]" ]; then
    echo "Mic Muted"
else
    echo "Mic On"
fi

