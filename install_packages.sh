#!/usr/bin/env bash

echo ">>> Installation des paquets pacman <<<"

sudo pacman -S --needed --noconfirm \
  hyprland \
  swww \
  waybar \
  rofi \
  kitty \
  hyprlock \
  nvidia \
  nvidia-utils \
  nvidia-settings \
  lib32-nvidia-utils \
  vulkan \
  vulkan-tools \
  vulkan-icd-loader \
  lib32-vulkan-icd-loader \
  gamemode \
  lib32-gamemode \
  python-pywal \
  starship \
  papirus-icon-theme \
  fastfetch \
  neovim \
  mako \
  zip \
  yazi \
  resvg \
  galculator \
  grim \
  slurp \
  wl-clipboard \
  brightnessctl \
  ddcutil \
  swayimg \
  cpupower \
  pavucontrol \
  ufw \
  inter-font \
  jq \
  ttf-cascadia-code \
  ttf-nerd-fonts-symbols \
  inter-font \
  adw-gtk-theme \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk

echo ">>> Installation des paquets AUR <<<"

yay -S --needed --noconfirm \
  librewolf-bin \
  python-pywalfox \
  ttf-font-awesome-5 \
  vscodium-bin \
  proton-ge-custom-bin
