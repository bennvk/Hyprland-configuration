#!/bin/bash

background=$(jq -r '.special.background' ~/.cache/wal/colors.json)
foreground=$(jq -r '.special.foreground' ~/.cache/wal/colors.json)
color1=$(jq -r '.colors.color1' ~/.cache/wal/colors.json)
color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)

cat > ~/.config/waybar/colors-wal.css <<EOF
#custom-os_button,
#workspaces,
#custom-musicplayer,
#window,
#custom-taskbar,
#pulseaudio,
#custom-cpu,
#custom-gpuNmemory,
#network,
#battery,
#battery.charging, #battery.plugged,
#battery.critical:not(.charging),
#clock,
#custom-configuration,
#custom-power,
#custom-separator,
#pulseaudio-slider {
    background-color: $color2;
}

tooltip {
    background: $color2;
}
EOF