#!/bin/bash

STEP=25
ACTION="$1"

mouse_pos=$(hyprctl cursorpos)
mouse_x=${mouse_pos%,*}

THRESHOLD=1920

if (( mouse_x < THRESHOLD )); then
    MAX=$(brightnessctl m)
    STEP_BC=$(( MAX / 10 ))

    CURRENT=$(brightnessctl g)

    if [[ "$ACTION" == "up" ]]; then
        NEW=$((CURRENT + STEP_BC))
    elif [[ "$ACTION" == "down" ]]; then
        NEW=$((CURRENT - STEP_BC))
    else
        echo "Usage : $0 up|down"
        exit 1
    fi

    (( NEW < 0 )) && NEW=0
    (( NEW > MAX )) && NEW=$MAX

    echo "🖥️ Écran laptop"
    echo "🔆 Luminosité : $CURRENT → $NEW"
    brightnessctl set "$NEW"

else
    # Écran secondaire (ddcutil)
    RAW=$(/usr/bin/ddcutil getvcp 10)
    CURRENT=$(echo "$RAW" | grep -oP 'current value\s*=\s*\K[0-9]+')

    if ! [[ "$CURRENT" =~ ^[0-9]+$ ]]; then
        echo "Erreur : impossible de récupérer la luminosité écran secondaire."
        exit 1
    fi

    if [[ "$ACTION" == "up" ]]; then
        NEW=$((CURRENT + STEP))
    elif [[ "$ACTION" == "down" ]]; then
        NEW=$((CURRENT - STEP))
    else
        echo "Usage : $0 up|down"
        exit 1
    fi

    (( NEW < 0 )) && NEW=0
    (( NEW > 100 )) && NEW=100

    echo "🖥️ Écran secondaire"
    echo "🔆 Luminosité : $CURRENT → $NEW"
    ddcutil setvcp 10 "$NEW"
fi

