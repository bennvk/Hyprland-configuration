#!/bin/bash

FLAG="$HOME/.config/waybar/waybar-visible.flag"

if [[ -f "$FLAG" ]]; then
  pkill waybar
  rm "$FLAG"
else
  touch "$FLAG"
  waybar &
fi
