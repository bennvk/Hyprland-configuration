#!/bin/bash

background=$(jq -r '.special.background' ~/.cache/wal/colors.json)
foreground=$(jq -r '.special.foreground' ~/.cache/wal/colors.json)
color1=$(jq -r '.colors.color1' ~/.cache/wal/colors.json)
color2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)

gradient() {
    hex=$1
    r=$((16#${hex:1:2}))
    g=$((16#${hex:3:2}))
    b=$((16#${hex:5:2}))
    r=$(( r * 80 / 100 ))
    g=$(( g * 80 / 100 ))
    b=$(( b * 80 / 100 ))
    printf "#%02x%02x%02x\n" $r $g $b
}

color2_gradient=$(gradient $color2)

cat > ~/.config/waybar/colors-wal.css <<EOF
#workspaces,
#window,
#custom-taskbar,
#custom-cpu,
#network,
#custom-configuration,
#custom-power {
    background: linear-gradient(90deg, $color2, $color2_gradient);
}

#custom-os_button,
#custom-musicplayer,
#pulseaudio,
#custom-gpuNmemory,
#clock {
    background: linear-gradient(90deg, $color2_gradient, $color2);
}

#custom-separator,
#battery,
#battery.charging,
#battery.plugged,
#battery.critical:not(.charging) {
    background: $color2_gradient;
}

tooltip {
    background: linear-gradient(135deg, $color2, $color2_gradient);
}
EOF
