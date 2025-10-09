#!/bin/bash

#
#     _____          _    _                                                     
#   /__   \__ _ ___| | _| |__   __ _ _ __           _ __ ___   ___ _ __  _   _ 
#     / /\/ _` / __| |/ / '_ \ / _` | '__|  _____  | '_ ` _ \ / _ \ '_ \| | | |
#    / / | (_| \__ \   <| |_) | (_| | |    |_____| | | | | | |  __/ | | | |_| |
#    \/   \__,_|___/_|\_\_.__/ \__,_|_|            |_| |_| |_|\___|_| |_|\__,_|
#                                                                           

source ~/.config/waybar/modules-scripts/taskbar_icons.sh

mapfile -t clients < <(hyprctl clients -j | jq -r '.[] | select(.mapped == true) | @base64')

entries=()
declare -A class_map

for client in "${clients[@]}"; do
  _jq() { echo "$client" | base64 -d | jq -r "$1"; }

  class=$(_jq '.class')
  title=$(_jq '.title')
  class_lc=$(echo "$class" | tr '[:upper:]' '[:lower:]')

  label="$(printf "%-8s %s" "$class" "$title")"
  entries+=("$label")
  class_map["$label"]="$class"
done

chosen=$(printf '%s\n' "${entries[@]}" | rofi -theme ~/.config/rofi/taskbar-menu/taskbar-menu.rasi -dmenu -i)

[ -n "$chosen" ] && hyprctl dispatch focuswindow class:^"${class_map[$chosen]}"$
