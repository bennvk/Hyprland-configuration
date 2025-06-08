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

##### Thunar #####

colors_file="$HOME/.cache/wal/colors"
output_gtk_css="$HOME/.config/gtk-3.0/gtk.css"

if [ -f "$colors_file" ]; then
    readarray -t colors < "$colors_file"

    background=${colors[0]}   # #0c080a
    foreground=${colors[15]}  # #ba9a97 (texte)
    color0=${colors[2]}       # #54211D (sidebar bg)
    color2=${colors[4]}       # #542926 (view selection bg)
    color4=${colors[6]}       # #70322D (non utilisé ici, mais c’est ok)
    color7=${colors[9]}       # #ba9a97 (texte clair)
    color9=${colors[11]}      # #70322D (sidebar sélection bg)
    color15=${colors[15]}     # #ba9a97 (texte)

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
    background-color: $color2;
    color: $color15;
}

.thunar .header,
.thunar .toolbar,
.thunar .menubar {
    background-color: $color0;
    color: $foreground;
}
EOF

    echo "gtk.css généré avec succès."
else
    echo "Erreur : fichier $colors_file introuvable."
fi


##### Starship prompt #####

~/.config/starship/theme.sh

##### Rofi #####

ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/colors.rasi

##### Firefox (Pywalfox) #####

pywalfox update
