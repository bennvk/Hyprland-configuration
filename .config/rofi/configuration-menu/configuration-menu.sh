#!/bin/bash
set -euo pipefail

if [[ -f "$HOME/.config/rofi/configuration-menu/mode-status.txt" ]]; then
    modestatus=$(<"$HOME/.config/rofi/configuration-menu/mode-status.txt")
fi

separator=$"-------------------------------------------"

chosen=$(printf "⚙️  Mode sélectionner : $modestatus\n"$separator"\n⚡  Performance\n⚖️  Équilibré\n🌿  Économie d'énergie\n🪫  Économie d'énergie ++" | \
  rofi -dmenu -theme ~/.config/rofi/configuration-menu/configuration-menu1.rasi) || exit 0

update_monitor() {
    local monitor="$1"
    local resolution="$2"
    local position="$3"
    local scale="$4"

    if grep -q "^monitor = $monitor" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = $monitor.*/monitor = $monitor, $resolution, $position, $scale/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = $monitor, $resolution, $position, $scale" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi
}

case "$chosen" in
  "*Mode sélectionner : $modestatus"*)
    exit 0
    ;;

  "$separator"*)
    exit 0
    ;;



  "⚡  Performance")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    powerprofilesctl set performance

    nmcli radio wifi on

    brightnessctl set 100%

    update_monitor "eDP-1" "1920x1080@144" "0x0" "1"
    update_monitor "DP-1" "1920x1080@180" "1920x0" "1"
    hyprctl reload

    echo "⚡  Performance" > $HOME/.config/rofi/configuration-menu/mode-status.txt

    ;;



  "⚖️  Équilibré")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    powerprofilesctl set balanced

    nmcli radio wifi on

    brightnessctl set 75%

    update_monitor "eDP-1" "1920x1080@144" "0x0" "1"
    update_monitor "DP-1" "1920x1080@180" "1920x0" "1"
    hyprctl reload

    echo "⚖️  Équilibré" > $HOME/.config/rofi/configuration-menu/mode-status.txt


    ;;



  "🌿  Économie d'énergie")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    powerprofilesctl set power-saver

    nmcli radio wifi on

    brightnessctl set 25%

    update_monitor "eDP-1" "1920x1080@60" "0x0" "1"
    update_monitor "DP-1" "1920x1080@60" "1920x0" "1"
    hyprctl reload

    echo "🌿  Économie d'énergie" > $HOME/.config/rofi/configuration-menu/mode-status.txt

    ;;



  "🪫  Économie d'énergie ++")
    pgrep swww-daemon > /dev/null && pkill swww-daemon
    pgrep waybar > /dev/null && pkill waybar

    powerprofilesctl set power-saver

    nmcli radio wifi off

    brightnessctl set 5%

    update_monitor "eDP-1" "1920x1080@60" "0x0" "1"
    update_monitor "DP-1" "1920x1080@60" "1920x0" "1"
    hyprctl reload

    echo "🪫  Économie d'énergie ++" > $HOME/.config/rofi/configuration-menu/mode-status.txt

    ;;
esac

echo "$chosen" > $HOME/.config/rofi/configuration-menu/mode-status.txt

password=""
unset password
exit 0