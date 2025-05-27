#!/bin/bash

##### Variables #####

WALLPAPER_PATH="$1"
THEME_DIR="$HOME/.vscode-pywal"
THEME_FILE="$THEME_DIR/pywal-color-theme.json"
COLORS_JSON="$HOME/.cache/wal/colors.json"

##### Palette Pywal #####

wal -i "$WALLPAPER_PATH" -n -q

#####Hyprpaper#####

cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALLPAPER_PATH
wallpaper = eDP-1,$WALLPAPER_PATH
wallpaper = DP-1,$WALLPAPER_PATH
EOF

##### Kitty #####

cat > ~/.config/kitty/colors.conf <<EOF
include ~/.cache/wal/colors-kitty.conf
EOF

##### Starship prompt #####

~/.config/starship/theme.sh

pywalfox update
hyprctl reload
pkill hyprpaper && hyprpaper &

##### Discord #####

wal -i $WALLPAPER_PATH
