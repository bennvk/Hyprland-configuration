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

    unit=$(printf " Secondes\n Minutes\n Heures\n Annuler" | rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu3.rasi)

    case "$unit" in
      Secondes) total_seconds=$((delay)) ;;
      Minutes) total_seconds=$((delay * 60)) ;;
      Heures) total_seconds=$((delay * 3600)) ;;
      Annuler|*) exit 1 ;;
      *)
        exit 1
        ;;
    esac

    shutdown -h +$((total_seconds / 60))
    notify-send "Arrêt programmé" "Dans $delay $unit"
    ;;
  *Annuler*) 
    exit 0 
    ;;
esac
