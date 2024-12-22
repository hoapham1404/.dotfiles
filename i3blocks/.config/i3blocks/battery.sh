#!/bin/bash

# Path to battery information
BATTERY_PATH="/sys/class/power_supply/BAT0"

# Read battery status, capacity, and remaining energy
STATUS=$(cat "$BATTERY_PATH/status")
CAPACITY=$(cat "$BATTERY_PATH/capacity")
CHARGE_NOW=$(cat "$BATTERY_PATH/charge_now" 2>/dev/null || cat "$BATTERY_PATH/energy_now")
CHARGE_FULL=$(cat "$BATTERY_PATH/charge_full" 2>/dev/null || cat "$BATTERY_PATH/energy_full")
POWER_NOW=$(cat "$BATTERY_PATH/power_now" 2>/dev/null || cat "$BATTERY_PATH/current_now")

# Calculate remaining time (if discharging)
if [ "$STATUS" = "Discharging" ]; then
    if [ -n "$POWER_NOW" ] && [ "$POWER_NOW" -gt 0 ]; then
        REMAINING_TIME=$(echo "scale=2; $CHARGE_NOW / $POWER_NOW" | bc)
        HOURS=$(echo "$REMAINING_TIME" | awk -F'.' '{print $1}')
        MINUTES=$(echo "scale=0; (0.$(echo "$REMAINING_TIME" | awk -F'.' '{print $2}') * 60)/1" | bc)
        REMAINING=$(printf "%02d:%02d" "$HOURS" "$MINUTES")
    else
        REMAINING="Calculating..."
    fi
else
    REMAINING="Charging"
fi

# Print formatted output
echo "$STATUS ${CAPACITY}% $REMAINING"

