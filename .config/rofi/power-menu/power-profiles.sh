#!/bin/bash

mode=$(printf "🔴  Performance\n🟡  Equilibré\n🟢  Économie\n💡  Activer les effets\n🔌  Désactiver les effets\n❌  Annuler" | \
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

  *Activer\ les\ effets*) 
    hyprctl reload
    notify-send "Mode de consommation" "Les effets sont activés"
    ;;

  *Désactiver\ les\ effets*)
    hyprctl --batch "
      keyword animations:enabled 0;
      keyword decoration:blur:enabled 0;
      keyword decoration:shadow:enabled 0;
      keyword decoration:rounding 0;
      keyword decoration:fullscreen_opacity 1;
      keyword decoration:blur:enabled 0;
      keyword decoration:dim_inactive 0;
      keyword general:gaps_in 0;
      keyword general:gaps_out 0;
      keyword general:border_size 1"
    notify-send "Mode de consommation" "Tous les effets sont désactivés"
    ;;

  *)
    exit 0
    ;;
esac