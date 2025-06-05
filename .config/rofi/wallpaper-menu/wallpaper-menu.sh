#!/bin/bash

wallpaper_dir="$HOME/Images/Wallpapers"

choices=$(find "$wallpaper_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \) | sort)

list=""
while IFS= read -r file; do
    name=$(basename "$file")
    list+="${name}\x00icon\x1f${file}\n"
done <<< "$choices"

selected_line=$(printf "$list" | rofi -dmenu -theme ~/.config/rofi/wallpaper-menu/wallpaper-menu.rasi -p "Choisir un fond d'écran")

selected_name=$(printf "%s" "$selected_line" | cut -d $'\x00' -f1)

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
