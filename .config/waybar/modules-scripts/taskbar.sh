#!/bin/bash

declare -A icons=(
  [firefox]=""
  [discord]=""
  [tidal-hifi]=""
  [Code]="󰨞"
  [Bitwarden]=""
  [obsidian]=""
  [kitty]=""
  [vlc]="󰕼"
  [Proton Mail]=""
  [chromium]=""
  [galculator]=""
  [virt-manager]="󰢔"
  [thunar]=""
)

classes=$(hyprctl clients -j | jq -r '.[] | select(.mapped == true) | .class' | sort | uniq)

output=""
while IFS= read -r class; do
  icon="${icons[$class]}"
  if [ -n "$icon" ]; then
    output+=" $icon"
  else
    output+=" [$class]"
  fi
done <<< "$classes"

echo "$output"
