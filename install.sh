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

echo "=== Installation des paquets pacman ==="

sudo pacman -S \
  hyprland awww waybar \
  rofi kitty zsh zsh-completions \
  hyprlock nvidia-utils nvidia-settings \
  lib32-nvidia-utils vulkan-tools \
  vulkan-icd-loader lib32-vulkan-icd-loader \
  gamemode lib32-gamemode python-pywal \
  starship papirus-icon-theme fastfetch \
  neovim mako zip yazi resvg galculator \
  grim slurp wl-clipboard cliphist \
  brightnessctl ddcutil swayimg \
  cpupower pavucontrol ufw jq \
  inter-font ttf-cascadia-code \
  ttf-nerd-fonts-symbols \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk

echo "=== Installation des paquets AUR ==="

yay -S \
  librewolf-bin \
  python-pywalfox \
  dracula-gtk-theme \
  vscodium-bin \
  proton-ge-custom-bin

echo "=== Installation de la session Hyprland terminé=== Installation de la session Hyprland terminéee"
