#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

battery_path="/sys/class/power_supply/BAT1"
status_file="$battery_path/status"
capacity_file="$battery_path/capacity"

state=$(cat "$status_file")
percentage=$(cat "$capacity_file")

if [ "$percentage" -lt 15 ] && [ "$state" = "Discharging" ]; then
    notify-send -i /home/benn/Images/Icons/battery-alert.png "Batterie faible" "$percentage% de batterie restants."
fi
