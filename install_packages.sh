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
  ttf-cascadia-code \
  papirus-icon-theme \
  fastfetch \
  neovim \
  mako \
  zip \
  nautilus \
  galculator \
  grim \
  slurp \
  wl-clipboard \
  brightnessctl \
  ddcutil \
  imv \
  cpupower \
  pavucontrol \
  ufw \
  inter-font \
  jq \
  ttf-cascadia-code \
  ttf-nerd-fonts-symbols \
  xdg-desktop-portal-hyprland

echo ">>> Installation des paquets AUR <<<"

yay -S --needed --noconfirm \
  librewolf-bin \
  python-pywalfox-librewolf \
  ttf-font-awesome-5 \
  vscodium-bin \
  proton-ge-custom-bin
