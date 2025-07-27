#!/bin/bash

WHITE="0xffffffff"
TRANSPARENT="0x00000000"

window_info=$(hyprctl activewindow -j)

is_floating=$(echo "$window_info" | jq -r '.floating')

if [[ "$is_floating" != "true" ]]; then
    hyprctl dispatch togglefloating activewindow
    hyprctl dispatch resizeactive exact 1500 900
    hyprctl dispatch centerwindow activewindow
fi

is_pinned=$(echo "$window_info" | jq -r '.pinned')

if [[ "$is_pinned" == "true" ]]; then
    hyprctl dispatch pin activewindow
    hyprctl dispatch setprop activewindow inactivebordercolor "$TRANSPARENT"
    hyprctl dispatch setprop activewindow activebordercolor "$TRANSPARENT"
else
    hyprctl dispatch pin activewindow
    hyprctl dispatch setprop activewindow inactivebordercolor "$WHITE"
    hyprctl dispatch setprop activewindow activebordercolor "$WHITE"
fi
