#!/bin/bash

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
    text="$icon   $artist - $title"
elif [ "$status" = "Paused" ]; then
    icon="  "
    text="$icon Mis en pause"
else
    exit 0
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"
