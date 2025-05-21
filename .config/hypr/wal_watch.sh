#!/bin/bash

WATCHED_FILE="$HOME/.config/hypr/hyprpaper.conf"

while true; do
    inotifywait -e modify "$WATCHED_FILE" >/dev/null 2>&1
    WALL=$(grep "wallpaper" "$WATCHED_FILE" | head -n 1 | cut -d',' -f2 | tr -d ' ')
    if [ -f "$WALL" ]; then
        ~/.config/hypr/wal_sync.sh "$WALL"
    fi
done
