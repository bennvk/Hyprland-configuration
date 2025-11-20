#!/bin/bash

STEP=25
ACTION="$1"

mouse_pos=$(hyprctl cursorpos)
mouse_x=${mouse_pos%,*}

THRESHOLD=1920

if (( mouse_x < THRESHOLD )); then
    MAX=$(brightnessctl m)
    STEP_BC=$(( MAX / 20 ))
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

    PERCENT=$(( NEW * 100 / MAX ))

    if (( PERCENT == 0 )); then
        ICON="$HOME/.config/mako/icons/brightness-zero.png"
    elif (( PERCENT <= 25 )); then
        ICON="$HOME/.config/mako/icons/brightness-low.png"
    elif (( PERCENT <= 50 )); then
        ICON="$HOME/.config/mako/icons/brightness-medium.png"
    elif (( PERCENT <= 75 )); then
        ICON="$HOME/.config/mako/icons/brightness-high.png"
    else
        ICON="$HOME/.config/mako/icons/brightness-max.png"
    fi

    brightnessctl set "$NEW" | \
        notify-send -i "$ICON" "$PERCENT%" \
        -a osd-panel \
        -e -h string:x-canonical-private-synchronous:osd

else
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

    if (( NEW <= 25 )); then
        ICON="$HOME/.config/mako/icons/brightness-low.png"
    elif (( NEW <= 50 )); then
        ICON="$HOME/.config/mako/icons/brightness-medium.png"
    elif (( NEW <= 75 )); then
        ICON="$HOME/.config/mako/icons/brightness-high.png"
    else
        ICON="$HOME/.config/mako/icons/brightness-max.png"
    fi

    ddcutil setvcp 10 "$NEW" | \
        notify-send -i "$ICON" "$NEW%" \
        -a osd-panel \
        -e -h string:x-canonical-private-synchronous:osd
fi