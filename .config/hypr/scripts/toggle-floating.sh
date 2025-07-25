#!/bin/bash

c=$(hyprctl cursorpos -j)
x=$(jq -r .x <<<"$c")
y=$(jq -r .y <<<"$c")

win=$(hyprctl clients -j | jq -r --argjson x $x --argjson y $y '
  [.[] | select(.at[0]<=$x and $x<(.at[0]+.size[0]) and .at[1]<=$y and $y<(.at[1]+.size[1]))][-1].address')

[[ -z $win ]] && exit

hyprctl dispatch focuswindow address:$win
hyprctl dispatch togglefloating address:$win
hyprctl dispatch resizeactive exact 1500 900
