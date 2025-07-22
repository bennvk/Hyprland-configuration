#!/bin/bash

CPU_SCRIPT="$HOME/.config/waybar/modules-scripts/cpu_toggle.sh"
GPU_SCRIPT="$HOME/.config/waybar/modules-scripts/gpu_toggle.sh"

if [[ "$WAYBAR_BUTTON" == "1" ]]; then
    "$CPU_SCRIPT" toggle
    "$GPU_SCRIPT" toggle
fi

cpu=$("$CPU_SCRIPT")
gpu=$("$GPU_SCRIPT")

echo "{\"text\": \"$cpu | $gpu\"}"
