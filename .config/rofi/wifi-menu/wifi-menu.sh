#!/bin/bash

#
#     __    __ _  __ _                                      
#    / / /\ \ (_)/ _(_)          _ __ ___   ___ _ __  _   _ 
#    \ \/  \/ / | |_| |  _____  | '_ ` _ \ / _ \ '_ \| | | |
#     \  /\  /| |  _| | |_____| | | | | | |  __/ | | | |_| |
#      \/  \/ |_|_| |_|         |_| |_| |_|\___|_| |_|\__,_|
#                                                       

confirm_action() {
  local message="$1"
  local choice=$(printf "✅ Valider\n❌ Annuler" | rofi -theme ~/.config/rofi/wifi-menu/wifi-menu4.rasi -dmenu -p "$message")
  [[ "$choice" == "✅ Valider" ]]
}

get_connection_status() {
  local status_parts=()

  local iface_wifi ssid
  iface_wifi=$(nmcli -t -f DEVICE,TYPE,STATE device | grep ":wifi:connected" | cut -d: -f1)
  if [[ -n "$iface_wifi" ]]; then
    ssid=$(nmcli -t -f GENERAL.CONNECTION device show "$iface_wifi" | cut -d: -f2-)
  fi

  while IFS=: read -r iface type state _; do
    if [[ "$state" == "connected" ]]; then
      case "$type" in
        ethernet)
          status_parts+=("\"Ethernet\"")
          ;;
        wifi)
          if [[ -n "$ssid" ]]; then
            status_parts+=("\"$ssid\"")
          else
            status_parts+=("\"Wi-Fi\"")
          fi
          ;;
      esac
    fi
  done < <(nmcli -t -f DEVICE,TYPE,STATE device)

  if [ ${#status_parts[@]} -eq 0 ]; then
    echo "📶 Statut de connexion : Aucune"
  else
    IFS=$'\n' sorted=($(sort <<<"${status_parts[*]}"))
    unset IFS
    echo "📶 Statut de connexion : $(IFS=, ; echo "${sorted[*]}")"
  fi
}

select_network() {
  local status_line=$(get_connection_status)
  local connections_label="📋 Voir les connexions établies"
  local separator="────────────────────────────────────────────────"

  local wifi_list=$(nmcli -f SSID,SIGNAL device wifi list | \
    awk 'NR>1 && $1 != "--" {print $0}' | \
    sort -k2 -nr | \
    awk '!seen[$1]++ {print $1}')

  printf "%s\n%s\n%s\n%s\n" "$status_line" "$connections_label" "$separator" "$wifi_list" | \
    rofi -theme ~/.config/rofi/wifi-menu/wifi-menu1.rasi -dmenu -p "Wifi"
}


select_action() {
  local ssid="$1"
  printf "Se connecter\nSe déconnecter\nEnregistrer le réseau\nSupprimer le réseau" | \
    rofi -theme ~/.config/rofi/wifi-menu/wifi-menu2.rasi -dmenu -p "$ssid"
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
      password=$(rofi -theme ~/.config/rofi/wifi-menu/wifi-menu3.rasi -dmenu -password -p "Mot de passe")
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

  case "$ssid" in
  "📋 Voir les connexions établies")
    nmcli -t -f NAME,TYPE,STATE connection show | \
      awk -F: '{printf "%-30s : %s\n", $1, $3}' | \
      rofi -theme ~/.config/rofi/wifi-menu/wifi-menu5.rasi -dmenu -no-custom
    exit
    ;;
    📶*)
      exit
      ;;
    "────────────────────────────────────────────────")
      exit
      ;;
  esac


  action=$(select_action "$ssid") || exit
  [ -z "$action" ] && exit

  process_action "$ssid" "$action"
}

main

