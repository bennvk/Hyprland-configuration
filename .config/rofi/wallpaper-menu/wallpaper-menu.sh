#!/bin/bash

wallpaper_dir="$HOME/Images/Wallpapers"
preview_dir="$HOME/Images/Wallpapers/preview"

mkdir -p "$preview_dir"

choices=$(find "$wallpaper_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \) ! -path "$preview_dir/*" | sort)

list=""
while IFS= read -r file; do
    name=$(basename "$file")
    base="${name%.*}"
    preview="$preview_dir/${base}_preview.jpg"

    echo "Vérification de la preview : $preview"
    if [ ! -f "$preview" ]; then
        echo "Création de la miniature pour $file"
        convert "$file" -resize 128x72 "$preview"
    else
        echo "Preview existe déjà, pas de création."
    fi

    list+="${name}\x00icon\x1f${preview}\n"
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
    bash -ic "~/.config/wal/wal-sync.sh '$selected'" >/dev/null 2>&1 &
fi
