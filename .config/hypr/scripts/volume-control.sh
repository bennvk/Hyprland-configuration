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

notify-send -i ~/.config/mako/icons/volume.png "$VOLUME%" -e -h string:x-canonical-private-synchronous:osd