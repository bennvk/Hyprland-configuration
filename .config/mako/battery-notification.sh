#!/bin/bash

info=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)

state=$(echo "$info" | grep "state" | awk '{print $2}')
percentage=$(echo "$info" | grep "percentage" | awk '{print $2}' | sed 's/%//')
is_charging=$(echo "$state" | grep -i charging)

if [ "$percentage" -lt 15 ] && [ -z "$is_charging" ]; then
    notify-send -u critical "⚠️ Batterie faible" "$percentage% de batterie restante."
fi

if [ "$percentage" -ge 99 ] && [ -n "$is_charging" ]; then
    notify-send -t 3000 "🔌 Batterie pleine"
fi

