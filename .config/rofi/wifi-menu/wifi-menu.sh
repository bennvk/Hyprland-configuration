#!/usr/bin/env bash

#
#     __    __ _  __ _                                      
#    / / /\ \ (_)/ _(_)          _ __ ___   ___ _ __  _   _ 
#    \ \/  \/ / | |_| |  _____  | '_ ` _ \ / _ \ '_ \| | | |
#     \  /\  /| |  _| | |_____| | | | | | |  __/ | | | |_| |
#      \/  \/ |_|_| |_|         |_| |_| |_|\___|_| |_|\__,_|
#   

IFACE="wlan0"
ROFI_CMD="rofi -dmenu -i -p WiFi"

current_ssid() {
    nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}'
}

list_networks() {
    nmcli -t -f SSID,SIGNAL device wifi list ifname "$IFACE" \
        | awk -F: 'NF && $1!="" {print $1 ":" $2}' \
        | sort -t: -k2 -nr \
        | cut -d: -f1
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
                ethernet) status_parts+=("\"Ethernet\"") ;;
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

network_menu() {
    SSID="$1"
    CONNECTED_SSID=$(current_ssid)

    if [[ "$SSID" == "$CONNECTED_SSID" ]]; then
        ACTION=$(printf "Déconnecter\nOublier\nRetour" | rofi -dmenu -i -p "Gestion $SSID" -theme $HOME/.config/rofi/wifi-menu/wifi-menu-manage.rasi)
        case "$ACTION" in
            "Déconnecter") nmcli connection down "$SSID" ;;
            "Oublier") nmcli connection delete "$SSID" ;;
        esac
    else
        ACTION=$(printf "Connecter\nOublier\nRetour" | rofi -dmenu -i -p "Gestion $SSID" -theme $HOME/.config/rofi/wifi-menu/wifi-menu-manage.rasi)
        case "$ACTION" in
            "Connecter")
                PASSWORD=$(echo "" | rofi -dmenu -password -p "Mot de passe pour $SSID" -theme $HOME/.config/rofi/wifi-menu/wifi-menu-password.rasi)
                if [[ -n "$PASSWORD" ]]; then
                    nmcli device wifi connect "$SSID" ifname "$IFACE" password "$PASSWORD"
                fi
                ;;
            "Oublier") nmcli connection delete "$SSID" ;;
        esac
    fi
}

show_connections() {
    SELECTED=$(nmcli -t -f NAME connection show | \
        rofi -dmenu -i -theme $HOME/.config/rofi/wifi-menu/wifi-menu-manage.rasi)

    [ -n "$SELECTED" ] && network_menu "$SELECTED"
}

main_menu() {
    NETWORKS=$(list_networks)
    STATUS=$(get_connection_status)
    WIFI_STATE=$(nmcli radio wifi)
    SEPARATOR="──────────────"

    HEADER1="$STATUS"
    HEADER2="📋 Voir les connexions"
    HEADER3="⚙️ Wi-Fi: $WIFI_STATE"

    MENU=$(printf "%s\n%s\n%s\n%s\n%s" \
        "$HEADER1" "$HEADER2" "$HEADER3" "$SEPARATOR" "$NETWORKS" | \
        rofi -dmenu -i -p WiFi -theme $HOME/.config/rofi/wifi-menu/wifi-menu-main.rasi)

    case "$MENU" in
        "$HEADER3")
            if [ "$WIFI_STATE" = "enabled" ]; then
                nmcli radio wifi off
            else
                nmcli radio wifi on
            fi
            ;;
        "$HEADER2") show_connections ;;
        "$HEADER1"|"$SEPARATOR") : ;;
        *) [ -n "$MENU" ] && network_menu "$MENU" ;;
    esac
}

main_menu