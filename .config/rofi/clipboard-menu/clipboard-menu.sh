#!/usr/bin/env bash

list=$(cliphist list)
idx=$(echo "$list" | awk -F'\t' '{print $2}' | rofi -theme ~/.config/rofi/clipboard-menu/clipboard-menu.rasi -dmenu -format i)

[ -z "$idx" ] && exit

line=$(echo "$list" | sed -n "$((idx+1))p")

case "$1" in
  delete) echo "$line" | cliphist delete ;;
  paste)  echo "$line" | cliphist decode | wl-copy ;;
esac
