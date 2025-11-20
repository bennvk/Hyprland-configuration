#!/bin/bash

ACTION="$1"

if [[ "$ACTION" == "up" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
elif [[ "$ACTION" == "down" ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ -5%
else
    exit 1
fi

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%')

if [[ "$VOLUME" -eq 0 ]]; then
    ICON="$HOME/.config/mako/icons/volume-mute.png"
elif [[ "$VOLUME" -le 30 ]]; then
    ICON="$HOME/.config/mako/icons/volume-low.png"
elif [[ "$VOLUME" -le 70 ]]; then
    ICON="$HOME/.config/mako/icons/volume-medium.png"
elif [[ "$VOLUME" -le 100 ]]; then
    ICON="$HOME/.config/mako/icons/volume-high.png"
else
    ICON="$HOME/.config/mako/icons/volume-gain.png"
fi

notify-send -i "$ICON" "$VOLUME%" -e -h string:x-canonical-private-synchronous:osd