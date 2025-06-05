#!/bin/bash

chosen=$(printf "  Éteindre\n  Redémarrer\n󰍃  Se déconnecter\n󰗽  Annuler" | rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu.rasi -p "Menu d'alimentation")

case "$chosen" in
  *Éteindre*) systemctl poweroff ;;
  *Redémarrer*) systemctl reboot ;;
  *Se\ déconnecter*) hyprctl dispatch exit ;;
  *Annuler*) exit 0 ;;
esac
