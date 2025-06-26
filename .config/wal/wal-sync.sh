#!/bin/bash

##### Variables #####

WALLPAPER_PATH="$1"
THEME_DIR="$HOME/.vscode-pywal"
THEME_FILE="$THEME_DIR/pywal-color-theme.json"
COLORS_JSON="$HOME/.cache/wal/colors.json"

##### Palette Pywal #####

wal -i "$WALLPAPER_PATH" -n -q

##### Kitty #####

cat > ~/.config/kitty/colors.conf <<EOF
include ~/.cache/wal/colors-kitty.conf
EOF

##### Waybar #####

bash ~/.config/waybar/colors-wal.sh
pkill waybar
waybar

##### Thunar #####

colors_file="$HOME/.cache/wal/colors"
output_gtk_css="$HOME/.config/gtk-3.0/gtk.css"

if [ -f "$colors_file" ]; then
    readarray -t colors < "$colors_file"

    background=${colors[0]}
    foreground=${colors[15]}  #texte
    color0=${colors[2]}       #sidebar bg
    color2=${colors[4]}       #view selection bg
    color4=${colors[6]}
    color7=${colors[9]}       #texte clair
    color9=${colors[11]}      #sidebar sélection bg
    color15=${colors[15]}     #texte

    mkdir -p "$(dirname "$output_gtk_css")"

    cat > "$output_gtk_css" <<EOF
* {
    background-color: $background;
    color: $foreground;
}

.thunar .sidebar {
    background-color: $color0;
    color: $color15;
}

.thunar .sidebar:selected {
    background-color: $color9;
    color: $color15;
    border: 1px solid $color15;
    box-shadow: inset 0 0 3px $color15;
}

.thunar .view {
    background-color: $background;
    color: $foreground;
}

.thunar .view:selected {
    background-color: $color0;
    color: $color15;
}

.thunar .header,
.thunar .toolbar,
.thunar .menubar {
    background-color: $color0;
    color: $foreground;
}
EOF
fi

##### Starship prompt #####

bash ~/.config/starship/theme.sh

##### Hyprlock #####

exten="${WALLPAPER_PATH##*.}"
target="/home/benn/.config/hyprlock/wp_hyprlock.$exten"

cp "$WALLPAPER_PATH" "$target"
ln -sf "$target" "/home/benn/.config/hyprlock/wp_hyprlock"

##### Rofi #####

ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/colors.rasi

##### Firefox (Pywalfox) #####

pywalfox update
