#!/bin/bash

confirm_action() {
  local message="$1"
  local choice=$(printf "✅ Valider\n❌ Annuler" | rofi -theme ~/.config/rofi/wifi-menu/wifi-menu4.rasi -dmenu -p "$message")
  [[ "$choice" == "✅ Valider" ]]
}

select_network() {
  nmcli -f SSID,SIGNAL device wifi list | awk 'NR>1 {print $1}' | grep -v '^--$' | sort -u | rofi -theme ~/.config/rofi/wifi-menu/wifi-menu1.rasi -dmenu
}

select_action() {
  local ssid="$1"
  printf "Se connecter\nSe déconnecter\nEnregistrer le réseau\nSupprimer le réseau" | rofi -theme ~/.config/rofi/wifi-menu/wifi-menu2.rasi -dmenu
}

process_action() {
  local ssid="$1"
  local action="$2"

  case "$action" in
    "Se connecter")
      if confirm_action "Se connecter au réseau '$ssid' ?"; then
        nmcli connection up "$ssid"
      fi
      ;;
    "Se déconnecter")
      if confirm_action "Se déconnecter de '$ssid' ?"; then
        nmcli connection down "$ssid"
      fi
      ;;
    "Enregistrer le réseau")
      password=$(rofi -theme ~/.config/rofi/wifi-menu/wifi-menu3.rasi -dmenu -password)
      if [ -n "$password" ] && confirm_action "Enregistrer et se connecter à '$ssid' ?"; then
        nmcli device wifi connect "$ssid" password "$password"
      fi
      ;;
    "Supprimer le réseau")
      if confirm_action "Supprimer la connexion '$ssid' ?"; then
        nmcli connection delete "$ssid"
      fi
      ;;
  esac
}

main() {
  ssid=$(select_network) || exit
  [ -z "$ssid" ] && exit

  action=$(select_action "$ssid") || exit
  [ -z "$action" ] && exit

  process_action "$ssid" "$action"
}

main
