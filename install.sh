#!/usr/bin/env bash

repo="https://github.com/bennvk/Hyprland-configuration.git"
configdir="$HOME/.config"

echo ">>> Script d'installation de la configuration <<<"

sleep 1

echo ">>> Installation des paquets et dépendances <<<"
sudo pacman -S --needed \
hyprland swww waybar rofi kitty hyprlock nvidia nvidia-utils nvidia-settings lib32-nvidia-utils vulkan vulkan-tools vulkan-icd-loader lib32-vulkan-icd-loader python-pywal starship ttf-cascadia-code papirus-icon-theme fastfetch neovim zip nautilus galculator grim slurp wl-clipboard brightnessctl ddcutil imv pavucontrol

yay -S --needed python-pywalfox ttf-font-awesome-5 vscodium-bin
pywalfox install

sleep 1

echo ">>> Copie de la configuration <<<"
cp -r .bashrc "$HOME/.bashrc"
cp -r .bash_profile "$HOME/.bash_profile"
cp -r .config/fastfetch "$configdir/fastfetch"
cp -r .config/help "$configdir/help"
cp -r .config/hypr "$configdir/hypr"
cp -r .config/hyprlock "$configdir/hyprlock"
cp -r .config/kitty "$configdir/kitty"
cp -r .config/nvim "$configdir/nvim"
cp -r .config/rofi "$configdir/rofi"
cp -r .config/starship "$configdir/starship"
cp -r .config/wal "$configdir/wal"
cp -r .config/waybar "$configdir/waybar"

sleep 1

read -p "Importer les fonds d'écrans ? [O/n] " choix_wp
case $choix_wp in
    [Oo]|"")
        cp -r Hyprland-Configuration/Images "$HOME/Images"
        ;;
    [Nn])
        ;;
    *)
        echo "Choix non valide, veuillez réessayer."
        exit 1
        ;;
esac

sleep 1

read -p "Importer la configuration de clavier qwerty ? [O/n] " choix_kb
case $choix_kb in
    [Oo]|"")
        sudo pacman -S --needed keyd
        sudo cp -r Hyprland-Configuration/etc/keyd /etc/keyd
        ;;
    [Nn])
        ;;
    *)
        echo "Choix non valide, veuillez réessayer."
        exit 1
        ;;
esac

echo ">>> Installation terminée avec succès 🎉"