#!/bin/bash

chosen=$(printf "  Éteindre\n  Redémarrer\n  Verrouiller\n  Se déconnecter\n  Arrêt planifié\n  Annuler" | \
  rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu1.rasi)

case "$chosen" in
  *Éteindre*) 
    systemctl poweroff 
    ;;
  *Redémarrer*) 
    systemctl reboot 
    ;;
  *Verouiller*)
    hyprlock --config ~/.config/hyprlock/hyprlock.conf
    ;;
  *Se\ déconnecter*) 
    hyprctl dispatch exit 
    ;;
  *Arrêt\ planifié*)
    input=$(rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu2.rasi -p "Durée (ex: 10m, 5 minutes, 1h)")

    [ -z "$input" ] && exit 1

    value=$(echo "$input" | grep -oE '^[0-9]+')

    unit=$(echo "$input" | grep -oEi '[a-z]+$' | tr '[:upper:]' '[:lower:]')

    case "$unit" in
      s|sec|secs|seconde|secondes) label="secondes" ; multiplier=1 ;;
      m|min|mins|minute|minutes)   label="minutes"  ; multiplier=60 ;;
      h|hr|heure|heures)           label="heures"   ; multiplier=3600 ;;
    *)
      exit 1
      ;;
    esac

    human="${value} ${label}"

    confirmation=$(printf "✅ Valider\n❌ Annuler" | \
      rofi -dmenu -theme ~/.config/rofi/power-menu/power-menu3.rasi -mesg "⏱️ Durée choisie : $human")

    [[ "$confirmation" == *"Annuler"* ]] && exit 0
    [[ "$confirmation" == *"Valider"* ]] || exit 1

    total_seconds=$((value * multiplier))
    sleep "$total_seconds" && systemctl poweroff
    ;;
esac
