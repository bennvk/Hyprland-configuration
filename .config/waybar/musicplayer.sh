#!/bin/bash

status=$(playerctl status 2>/dev/null)
artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""
else
    exit 0
fi

text="$icon   $artist - $title"

echo "{\"text\": \"$text\", \"tooltip\": \"$artist - $title\"}"

