#!/usr/bin/env bash

configdir="$HOME/.config"

echo ">>> Script d'installation de la configuration <<<"

sleep 1

echo ">>> Installation des paquets et dépendances <<<"

./install_packages.sh || { echo "Erreur lors de l'installation des paquets."; exit 1; }

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
        cp -r Images "$HOME/Images"
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
        sudo cp -r etc/keyd /etc/keyd
        ;;
    [Nn])
        ;;
    *)
        echo "Choix non valide, veuillez réessayer."
        exit 1
        ;;
esac

echo ">>> Installation terminée avec succès 🎉"
