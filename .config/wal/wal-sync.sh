#!/bin/bash

WALLPAPER_PATH="$1"

##### Palette Pywal #####

wal -i "$WALLPAPER_PATH" -n -q

##### Kitty #####

cat > ~/.config/kitty/colors.conf <<EOF
include ~/.cache/wal/colors-kitty.conf
EOF

##### Waybar #####

bash ~/.config/waybar/colors-wal.sh

pkill waybar
waybar &

##### Starship prompt #####

bash ~/.config/starship/theme.sh

##### Hyprlock #####

exten="${WALLPAPER_PATH##*.}"
target="$HOME/.config/hyprlock/wp_hyprlock.$exten"

cp "$WALLPAPER_PATH" "$target"
ln -sf "$target" "$HOME/.config/hyprlock/wp_hyprlock"

##### Rofi #####

ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/shared/colors.rasi

##### Firefox (Pywalfox) #####

pywalfox update
