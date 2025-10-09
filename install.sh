#!usr/bin/env bash

repo="https://github.com/bennvk/Hyprland-configuration.git"
configdir=$HOME/.config

echo ">>> Clonage du dépôt <<<"
git clone $repo

sleep 1

echo ">>> Installation des paquets et dépendances <<<"
sudo pacman -S --needed \
  hyprland swww waybar rofi bash kitty hyprlock \
  python-pywal starship ttf-cascadia-code ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common papirus-icon-theme fastfetch \
  neovim zip nautilus galculator grim slurp wl-clipboard brightnessctl ddcutil imv pavucontrol

yay -S --needed python-pywalfox ttf-font-awesome-5
pywalfox install

sleep 1

echo ">>> Copie de la configuration <<<"
cp Hyprland-Configuration/.bashrc $HOME/.bashrc
cp Hyprland-Configuration/.bash_profile $HOME/.bash_profile
cp Hyprland-Configuration/.config/fastfetch $configdir/fastfetch
cp Hyprland-Configuration/.config/help $configdir/help
cp Hyprland-Configuration/.config/hypr $configdir/hypr
cp Hyprland-Configuration/.config/hyprlock $configdir/hyprlock
cp Hyprland-Configuration/.config/kitty $configdir/kitty
cp Hyprland-Configuration/.config/nvim $configdir/nvim
cp Hyprland-Configuration/.config/rofi $configdir/rofi
cp Hyprland-Configuration/.config/starship $configdir/starship
cp Hyprland-Configuration/.config/wal $configdir/wal
cp Hyprland-Configuration/.config/fastfetch $configdir/waybar

sleep 1

read -p "Importer les fonds d'écrans ? [O/n]" choix_wp

case $choix_wp in
    [Oo]) 
        sudo cp Hyprland-Configuration/Images $HOME/Images
        ;;
    [Nn]) 
        ;;
    *) echo "Choix non valide, veuillez réessayer"
       exit 1
       ;;
esac

sleep 1

read -p "Importer la configuration de clavier qwerty ? [O/n]" choix_kb

case $choix_kb in
    [Oo]) 
        sudo cp Hyprland-Configuration/etc/keyd /etc/keyd
        ;;
    [Nn]) 
        ;;
    *) echo "Choix non valide, veuillez réessayer"
       exit 1
       ;;
esac
