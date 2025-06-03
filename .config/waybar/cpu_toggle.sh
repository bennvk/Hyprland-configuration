#!/bin/bash

STATE_FILE="/tmp/waybar_cpu_state"
STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "temp")

if [[ "$1" == "toggle" ]]; then
    if [[ "$STATE" == "temp" ]]; then
        echo "usage" > "$STATE_FILE"
    else
        echo "temp" > "$STATE_FILE"
    fi
    exit 0
fi

if [[ "$STATE" == "temp" ]]; then
    TEMP=$(sensors | grep -m1 'Package id 0' | awk '{print $4}' | sed 's/+//;s/°C//')
    echo "CPU ${TEMP}°C "
else
    USAGE=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.0f", usage}')
    echo "${USAGE}% "
fi
