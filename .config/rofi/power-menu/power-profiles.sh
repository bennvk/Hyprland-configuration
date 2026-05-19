#!/bin/bash

mode=$(printf "🔴  Performance\n🟡  Équilibré\n🟢  Économie\n❌  Annuler" | \
  rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu1.rasi)

case "$mode" in
  *Performance*) 
    powerprofilesctl set performance \
      && notify-send "Mode de performance" "Le mode Performance a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  *Équilibré*) 
    powerprofilesctl set balanced \
      && notify-send "Mode de performance" "Le mode Équilibré a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  *Économie*)
    powerprofilesctl set power-saver \
      && notify-send "Mode de performance" "Le mode Économie d'énergie a été activé" \
      || notify-send "⚠️ Erreur ⚠️" "Le mode de performance n'a pas pu être appliqué"
    ;;
  *)
    exit 0
    ;;
esac
