#!/bin/bash

mode=$(printf "🔴  Performance\n🟡  Equilibré\n🟢  Économie\n❌  Annuler" | \
  rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu1.rasi)

case "$mode" in
  *Performance*) 
    powerprofilesctl set performance
    ;;

  *Equilibré*) 
    powerprofilesctl set balanced
    ;;

  *Économie*)
    powerprofilesctl set power-saver
    ;;
  *)
    exit 0
    ;;
esac
