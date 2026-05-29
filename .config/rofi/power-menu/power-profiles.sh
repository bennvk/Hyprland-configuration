#!/bin/bash

mode=$(printf "\n󰾅\n󰌪" | \
  rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu4.rasi)

case "$mode" in
  ) 
    powerprofilesctl set performance \
      && notify-send "Mode de performance" "Le mode Performance a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  󰾅) 
    powerprofilesctl set balanced \
      && notify-send "Mode de performance" "Le mode Équilibré a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  󰌪)
    powerprofilesctl set power-saver \
      && notify-send "Mode de performance" "Le mode Économie d'énergie a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  *)
    exit 0
    ;;
esac
