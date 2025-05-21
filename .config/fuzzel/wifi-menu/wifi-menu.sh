#!/bin/bash

connecter() {
    if ! systemctl is-active --quiet NetworkManager; then
        notify-send "Erreur : NetworkManager n'est pas actif"
        exit 1
    fi

    # Récupère la liste des réseaux disponibles (avec sécurité)
    networks=$(nmcli -t -f SSID,SECURITY dev wifi list | grep -v '^--' | sort -u)

    # Formatage pour affichage
    choices=$(echo "$networks" | awk -F':' '{print $1 " [" $2 "]"}' | fuzzel --dmenu --config ~/.config/fuzzel/wifi-menu/wifi-menu.ini )

    # Choix via fuzzel
    selection=$(echo "$choices" | fuzzel --dmenu --prompt "Wi-Fi : " --config ~/.config/fuzzel/wifi-menu/wifi-menu.ini)

    # Annule si aucun choix
    [ -z "$selection" ] && exit

    # Extrait le SSID réel (avant le "[SECURITY]")
    ssid=$(echo "$selection" | sed 's/ \[.*\]//')

    # Vérifie si sécurisé
    is_secured=$(echo "$selection" | grep -o '\[.*\]' | grep -q WPA && echo yes || echo no)

    # Demande identifiant et mot de passe pour WPA2-Enterprise (EAP)
    if [ "$is_secured" = "yes" ]; then
        # Si c'est un réseau WPA2-Enterprise (EAP)
        security_type=$(echo "$selection" | grep -o '\[.*\]' | sed 's/\[\(.*\)\]/\1/')

        if [[ "$security_type" == "WPA2-Enterprise" ]]; then
            # Demande un identifiant et un mot de passe pour EAP
            username=$(fuzzel --dmenu --prompt "Identifiant : ")
            password=$(fuzzel --dmenu --prompt "Mot de passe : " --password)

            [ -z "$username" ] && notify-send "Annulé" && exit
            [ -z "$password" ] && notify-send "Annulé" && exit

            # Création du profil avec les informations EAP
            nmcli dev wifi connect "$ssid" \
                identity "$username" \
                password "$password" \
                --eap peap \
                --phase2-auth mschapv2 && \
                notify-send "Connecté à $ssid" || \
                notify-send "Échec de connexion à $ssid"
        else
            # Si le réseau utilise WPA simple (pas WPA2-Enterprise)
            password=$(fuzzel --dmenu --prompt "Mot de passe : " --password)
            [ -z "$password" ] && notify-send "Annulé" && exit

            nmcli dev wifi connect "$ssid" password "$password" && \
                notify-send "Connecté à $ssid" || \
                notify-send "Échec de connexion à $ssid"
        fi
    else
        # Si le réseau n'est pas sécurisé (open network)
        nmcli dev wifi connect "$ssid" && \
            notify-send "Connecté à $ssid" || \
            notify-send "Échec de connexion à $ssid"
    fi
}

# Lancer le processus de connexion Wi-Fi
connecter
