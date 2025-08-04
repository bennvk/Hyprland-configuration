#!/bin/bash

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
    if [ -z "$artist" ]; then
        text="$icon   $title"
        tooltip="$title"
    else
        text="$icon   $artist - $title"
        tooltip="$artist - $title"
    fi
elif [ "$status" = "Paused" ]; then
    icon="  "
    text="$icon Pause"
    tooltip="Lecteur en pause"
else
    exit 0
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
