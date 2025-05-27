#!/bin/bash

main_menu="  Éteindre\n  Redémarrer\n  Fermer session\n  Arrêt programmé\n  Annuler"

choice=$(echo -e "$main_menu" | fuzzel --dmenu --config ~/.config/fuzzel/power-menu/power-menu.ini)

case "$choice" in
    "  Éteindre")
        shutdown now
        ;;

    "  Redémarrer")
        shutdown -r now
        ;;

    "  Fermer session")
        hyprctl dispatch exit
        ;;

    "  Arrêt programmé")
        delay_menu="1 min\n5 min\n10 min\n30 min\nAnnuler"
        delay_choice=$(echo -e "$delay_menu" | fuzzel --dmenu --config ~/.config/fuzzel/power-menu/power-menu.ini)

        case "$delay_choice" in
            "1 min")
                delay=60
                ;;
            "5 min")
                delay=300
                ;;
            "10 min")
                delay=600
                ;;
            "30 min")
                delay=1800
                ;;
            "Annuler"|"")
                exit 0
                ;;
            *)
                exit 1
                ;;
        esac

        notify-send "Arrêt programmé" "Le PC s'éteindra dans $((delay / 60)) minute(s)"
        (sleep "$delay" && systemctl poweroff) &
        ;;

    "  Annuler"|"")
        exit 0
        ;;
esac
