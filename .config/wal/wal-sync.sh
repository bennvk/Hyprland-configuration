#!/bin/bash

##### Variables #####

WALLPAPER_PATH="$1"
THEME_DIR="$HOME/.vscode-pywal"
THEME_FILE="$THEME_DIR/pywal-color-theme.json"
COLORS_JSON="$HOME/.cache/wal/colors.json"

##### Palette Pywal #####

wal -i "$WALLPAPER_PATH" -n -q

##### Fond d'écran avec SWWW #####

monitors=$(hyprctl monitors -j | jq -r '.[].name' | paste -sd "," -)

swww img "$WALLPAPER_PATH" \
  --outputs "$monitors" \
  --transition-type grow \
  --transition-pos 0.5,0.5 \
  --transition-duration 1 \
  --transition-fps 60

##### Kitty #####

cat > ~/.config/kitty/colors.conf <<EOF
include ~/.cache/wal/colors-kitty.conf
EOF

##### Starship prompt #####

~/.config/starship/theme.sh

##### Rofi #####

ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/colors.rasi

##### Firefox (Pywalfox) #####

pywalfox update
