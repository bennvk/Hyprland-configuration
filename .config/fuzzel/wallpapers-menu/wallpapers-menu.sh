#!/bin/bash

WALL_DIR="$HOME/Images/Wallpapers"
CONF_FILE="$HOME/.config/hypr/hyprpaper.conf"

selected=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) \
  -exec basename {} \; | sort | fuzzel --dmenu --config "$HOME/.config/fuzzel/wallpapers-menu/wallpapers-menu.ini" --prompt "Choisir un fond d'écran : ")

if [ -n "$selected" ]; then
    filepath="$WALL_DIR/$selected"

    monitors=$(hyprctl monitors -j | jq -r '.[].name')

    echo "preload = $filepath" > "$CONF_FILE"
    for m in $monitors; do
        echo "wallpaper = $m,$filepath" >> "$CONF_FILE"
    done
fi
