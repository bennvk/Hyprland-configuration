#!/bin/bash
set -euo pipefail

chosen=$(printf "⚡  Mode Performance\n⚖️  Mode Équilibré\n🌿  Mode Économie d'énergie\n🪫  Mode Économie d'énergie ++" | \
  rofi -dmenu -theme ~/.config/rofi/configuration-menu/configuration-menu1.rasi) || exit 0

password=$(rofi -dmenu -password -theme ~/.config/rofi/configuration-menu/configuration-menu2.rasi | tr -d '\n')

run_sudo() {
    printf '%s\n' "$password" | sudo -S -p '' "$@" || true
}

case "$chosen" in
  "⚡  Mode Performance")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    run_sudo nvidia-smi -pm 1
    run_sudo nvidia-smi -pl 120   # Limite max GPU
    run_sudo nvidia-smi -lgc 2100,3105
    run_sudo nvidia-smi -lmc 7000,8001

    run_sudo powerprofilesctl set performance
    run_sudo cpupower frequency-set -g performance

    if grep -q "^monitor = eDP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = eDP-1.*/monitor = eDP-1, 1920x1080@144, 0x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = eDP-1, 1920x1080@144, 0x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi

    if grep -q "^monitor = DP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = DP-1.*/monitor = DP-1, 1920x1080@144, 1920x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = DP-1, 1920x1080@144, 1920x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi
    hyprctl reload
    ;;

  "⚖️  Mode Équilibré")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    run_sudo nvidia-smi -pm 1
    run_sudo nvidia-smi -pl 100   # Valeur sécurisée
    run_sudo nvidia-smi -lgc 1000,2200
    run_sudo nvidia-smi -lmc 4000,7000

    run_sudo powerprofilesctl set balanced
    run_sudo cpupower frequency-set -g schedutil

    if grep -q "^monitor = eDP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = eDP-1.*/monitor = eDP-1, 1920x1080@144, 0x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = eDP-1, 1920x1080@144, 0x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi

    if grep -q "^monitor = DP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = DP-1.*/monitor = DP-1, 1920x1080@60, 1920x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = DP-1, 1920x1080@60, 1920x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi
    hyprctl reload
    ;;

  "🌿  Mode Économie d'énergie")
    pgrep swww-daemon > /dev/null || swww-daemon &
    pgrep waybar > /dev/null || waybar &

    run_sudo systemctl stop bluetooth.service

    run_sudo nvidia-smi -pm 1
    run_sudo nvidia-smi -pl 80
    run_sudo nvidia-smi -lgc 600,1500
    run_sudo nvidia-smi -lmc 2000,4000

    run_sudo powerprofilesctl set power-saver
    run_sudo cpupower frequency-set -g powersave

    if grep -q "^monitor = eDP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = eDP-1.*/monitor = eDP-1, 1920x1080@60, 0x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = eDP-1, 1920x1080@60, 0x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi

    if grep -q "^monitor = DP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = DP-1.*/monitor = DP-1, 1920x1080@60, 1920x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = DP-1, 1920x1080@60, 1920x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi
    hyprctl reload
    ;;

  "🪫  Mode Économie d'énergie ++")
    pgrep swww-daemon > /dev/null && pkill swww-daemon
    pgrep waybar > /dev/null && pkill waybar

    run_sudo systemctl stop bluetooth.service
    nmcli radio wifi off

    run_sudo nvidia-smi -pm 0
    run_sudo nvidia-smi -pl 50
    run_sudo nvidia-smi -lgc 210,600
    run_sudo nvidia-smi -lmc 405,810
    run_sudo systemctl stop nvidia-persistenced

    run_sudo powerprofilesctl set power-saver
    run_sudo cpupower frequency-set -g powersave

    if grep -q "^monitor = eDP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = eDP-1.*/monitor = eDP-1, 1920x1080@60, 0x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = eDP-1, 1920x1080@60, 0x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi

    if grep -q "^monitor = DP-1" "$HOME/.config/hypr/source-hyprland/monitors.conf"; then
        sed -i "s/^monitor = DP-1.*/monitor = DP-1, 1920x1080@60, 1920x0, 1/" "$HOME/.config/hypr/source-hyprland/monitors.conf"
    else
        echo "monitor = DP-1, 1920x1080@60, 1920x0, 1" >> "$HOME/.config/hypr/source-hyprland/monitors.conf"
    fi
    hyprctl reload
    ;;
esac

password=""
unset password
exit 0