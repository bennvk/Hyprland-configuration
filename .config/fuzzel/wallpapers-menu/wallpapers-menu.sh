#!/bin/bash

WALL_DIR="$HOME/Images/Wallpapers"

selected=$(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) \
  -exec basename {} \; | sort | fuzzel --dmenu --config "$HOME/.config/fuzzel/wallpapers-menu/wallpapers-menu.ini" --prompt "Choisir un fond d'écran : ")

if [ -n "$selected" ]; then
    filepath="$WALL_DIR/$selected"
    ~/.config/hypr/wal_sync.sh "$filepath"
fi
