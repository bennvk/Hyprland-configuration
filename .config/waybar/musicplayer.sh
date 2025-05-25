#!/bin/bash

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
elif [ "$status" = "Paused" ]; then
    icon=""
else
    echo '{"text": "", "tooltip": "Aucune lecture en cours"}'
    exit 0
fi

text="$icon $artist - $title"

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"

