#!/bin/bash

layout=$(hyprctl getoption general:layout | awk 'NR==1{print $2}')

if [ "$layout" = "dwindle" ]; then
    hyprctl keyword general:layout master
else
    hyprctl keyword general:layout dwindle
fi