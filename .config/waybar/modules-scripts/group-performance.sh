#!/bin/bash

CPU_SCRIPT="$HOME/.config/waybar/modules-scripts/cpu_toggle.sh"
GPU_SCRIPT="$HOME/.config/waybar/modules-scripts/gpu_toggle.sh"

if [[ "$1" == "click" ]]; then
    "$CPU_SCRIPT" toggle
    "$GPU_SCRIPT" toggle
fi

bash /home/benn/.config/waybar/modules-scripts/group-performance-display.sh
