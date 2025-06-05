#!/bin/bash

wallpaper_dir="$HOME/Images/Wallpapers"

choices=$(find "$wallpaper_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \) | sort)

names=$(basename -a $choices)

selected_name=$(printf "%s\n" "$names" | rofi -dmenu -theme ~/.config/rofi/wallpaper-menu/wallpaper-menu.rasi -p "Choisir un fond d'écran")

selected=$(printf "%s\n" "$choices" | grep "/$selected_name$")

if [ -n "$selected" ]; then
    swww img "$selected" \
    --outputs "$monitors" \
    --transition-type grow \
    --transition-pos 0.5,0.5 \
    --transition-duration 1 \
    --transition-fps 60
    bash ~/.config/wal/wal-sync.sh "$selected"
fi
