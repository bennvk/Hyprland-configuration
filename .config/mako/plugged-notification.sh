#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

prev_file="$HOME/.cache/battery-plugged-state"
[ -f "$prev_file" ] || echo "unknown" > "$prev_file"

upower --monitor | while read -r line; do
    if echo "$line" | grep -q "battery_BAT1"; then
        state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/state:/ {print $2}')
        prev_state=$(cat "$prev_file")

        if [ "$state" = "charging" ] && [ "$prev_state" != "charging" ]; then
            percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/percentage:/ {gsub("%", ""); print $2}')
            notify-send -i /home/benn/Images/Icons/battery-charging.png -t 3000 "🔌 Batterie en charge" "$percentage% de batterie chargée"
        fi

        echo "$state" > "$prev_file"
    fi
done

