#!/bin/bash

window_id=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true).id')
is_floating=$(swaymsg -t get_tree | jq ".. | select(.id? == $window_id) | .floating")

if [[ "$is_floating" == "\"user_on\"" ]]; then
    # Already in faux fullscreen: go back to normal
    swaymsg "[con_id=$window_id]" floating disable
    swaymsg "[con_id=$window_id]" border pixel
else
    # Enter faux fullscreen
    swaymsg "[con_id=$window_id]" border none
    swaymsg "[con_id=$window_id]" floating enable
    swaymsg "[con_id=$window_id]" resize set 200 ppt 200 ppt
fi
