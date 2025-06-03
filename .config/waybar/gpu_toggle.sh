#!/bin/bash

STATE_FILE="/tmp/waybar_gpu_state"
STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "temp")

if [[ "$1" == "toggle" ]]; then
    if [[ "$STATE" == "temp" ]]; then
        echo "mem" > "$STATE_FILE"
    else
        echo "temp" > "$STATE_FILE"
    fi
    exit 0
fi

if [[ "$STATE" == "temp" ]]; then
    TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
    echo "GPU ${TEMP}°C "
else
    USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits | awk '{print $1}')
    TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | awk '{print $1}')
    PERCENT=$(( USED * 100 / TOTAL ))
    echo "RAM  ${PERCENT}% "
fi
