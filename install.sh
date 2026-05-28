#!/bin/bash

set -euo pipefail

scriptpwd="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/Images/Screenshots"
mkdir -p "$HOME/Images/Wallpapers"

echo "=== Copie des fichiers de configurations ==="

configs=(
    fastfetch fontconfig hypr
    hyprlock kitty mako nvim
    rofi starship VSCodium wal
    waybar yazi
)

for cfg in "${configs[@]}"; do
    mkdir -p "$HOME/.config/$cfg"
    cp -R "$scriptpwd/.config/$cfg/." "$HOME/.config/$cfg/"
done

find "$HOME/.config/hypr" -type f -name "*.sh" -exec chmod +x {} \;

sleep 1

read -rp "Importer les fonds d'écran ? (o/n) : " rep

if [[ "$rep" == "o" || "$rep" == "O" ]]; then
    echo "=== Importation des fonds d'écran ==="
    cp -R "$scriptpwd/Images/Wallpapers/." "$HOME/Images/Wallpapers"
fi

sleep 1

echo "=== Configuration de Zsh ==="

if command -v zsh &>/dev/null; then
    chsh -s "$(command -v zsh)" "$USER"
fi

cp "$scriptpwd/.zshrc" "$HOME/.zshrc"
cp "$scriptpwd/.zprofile" "$HOME/.zprofile"

sleep 1

echo "=== Installation de la session Hyprland terminée ==="
