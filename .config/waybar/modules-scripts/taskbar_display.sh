#!/bin/bash

source ~/.config/waybar/modules-scripts/taskbar_icons.sh

classes=$(hyprctl clients -j | jq -r '.[] | select(.mapped == true) | .class' | sort | uniq)

if [[ -z "$classes" ]]; then
  exit 0
fi

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
