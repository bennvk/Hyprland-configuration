#!/bin/bash

chosen=$(printf "  Éteindre\n  Redémarrer\n  Se déconnecter\n  Arrêt planifié\n  Annuler" | \
  rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu1.rasi)

case "$chosen" in
  *Éteindre*) 
    systemctl poweroff 
    ;;
  *Redémarrer*) 
    systemctl reboot 
    ;;
  *Se\ déconnecter*) 
    hyprctl dispatch exit 
    ;;
  *Arrêt\ planifié*)
    delay=$(rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu2.rasi)

    if ! [[ "$delay" =~ ^[0-9]+$ ]]; then
      exit 1
    fi

    unit=$(printf " Secondes\n Minutes\n Heures\n Annuler" | rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu3.rasi)

    unit=$(echo "$unit" | awk '{print $2}')

    case "$unit" in
      Secondes) total_seconds=$((delay)) ;;
      Minutes) total_seconds=$((delay * 60)) ;;
      Heures) total_seconds=$((delay * 3600)) ;;
      Annuler|*) exit 1 ;;
    esac

    sleep "$total_seconds" && systemctl poweroff
    ;;
esac
