#!/bin/bash

##### Variables #####

WALLPAPER_PATH="$1"
THEME_DIR="$HOME/.vscode-pywal"
THEME_FILE="$THEME_DIR/pywal-color-theme.json"
COLORS_JSON="$HOME/.cache/wal/colors.json"
success=true

##### Palette Pywal #####

wal -i "$WALLPAPER_PATH" -n -q || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Création de la palette Pywal"; }

##### Kitty #####

cat > ~/.config/kitty/colors.conf <<EOF
include ~/.cache/wal/colors-kitty.conf
EOF
[ $? -ne 0 ] && { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Mise à jour de Kitty"; }

##### Waybar #####

bash ~/.config/waybar/colors-wal.sh || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Exécution de colors-wal pour Waybar"; }

pkill waybar
waybar &

##### Thunar #####

colors_file="$HOME/.cache/wal/colors"
output_gtk_css="$HOME/.config/gtk-3.0/gtk.css"

if [ -f "$colors_file" ]; then
    readarray -t colors < "$colors_file"

    background=${colors[0]}
    foreground=${colors[15]}
    color0=${colors[2]}
    color2=${colors[4]}
    color4=${colors[6]}
    color7=${colors[9]}
    color9=${colors[11]}
    color15=${colors[15]}

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

else
    success=false
    notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Fichier de couleurs pour Thunar introuvable"
fi

##### Starship prompt #####

bash ~/.config/starship/theme.sh || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Mise à jour de Starship prompt"; }

##### Mako #####

background=$(jq -r '.colors.color0' "$COLORS_JSON") || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Lecture de color0 pour Mako"; }
text=$(jq -r '.colors.color7' "$COLORS_JSON") || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Lecture de color7 pour Mako"; }

cat > "$HOME/.config/mako/config" <<EOF
background-color=$background
text-color=$text
border-color=#ffffff
font=Mononoki 11

border-size=1
border-radius=6
padding=10
margin=10
anchor=top-right

default-timeout=5000
max-history=100
max-visible=5
icons=true
max-icon-size=64

width=537
height=250

[app-name="tidal-hifi"]
invisible=1
EOF

makoctl reload || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Redémarrage de Mako"; }

##### Hyprlock #####

exten="${WALLPAPER_PATH##*.}"
target="$HOME/.config/hyprlock/wp_hyprlock.$exten"

cp "$WALLPAPER_PATH" "$target" || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Copie du fond d'écran pour Hyprlock"; }
ln -sf "$target" "$HOME/.config/hyprlock/wp_hyprlock" || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Lien symbolique pour Hyprlock"; }

##### Rofi #####

ln -sf ~/.cache/wal/colors-rofi-dark.rasi ~/.config/rofi/colors.rasi || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Mise à jour de Rofi"; }

##### Firefox (Pywalfox) #####

pywalfox update || { success=false && notify-send -i ~/Images/Icons/wallpaper.png -t 5000 "Mise à jour du fond d'écran ❌" "Erreur : Mise à jour de PywalFox"; }

##### Notification finale #####

if [ "$success" = true ]; then
    notify-send -i ~/Images/Icons/wallpaper.png -t 3000 "Mise à jour du fond d'écran ✅" "Fond d'écran modifié avec succès"
fi
