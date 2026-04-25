#!/bin/bash

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
while read -r line; do
    if [[ "$line" == activewindow* ]]; then
        addr=$(hyprctl activewindow -j | jq -r 'select(.workspace.name == "special:minimized") | .address')
        if [[ -n "$addr" ]]; then
            hyprctl dispatch movetoworkspace "e+0,address:$addr"
        fi
    fi
done
