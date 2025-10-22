# ~/.bashrc

[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'

alias mega-start='mega-sync --enable /home/benn/Megasync/'
alias mega-stop='mega-sync -p /home/benn/Megasync/'
alias mega-status='mega-sync'

alias powermode-status='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias powermode-powersave='sudo cpupower frequency-set -g powersave'
alias powermode-performance='sudo cpupower frequency-set -g performance'

alias hyprlock='hyprlock --config ~/.config/hyprlock/hyprlock.conf'

alias help-ytdlp='cat ~/.config/help/help_ytdlp.txt'
alias help-nmcli='cat ~/.config/help/help_nmcli.txt'
alias help-bindsHyprland='cat ~/.config/help/help_bindsHyprland.txt'
alias help-pacman='cat ~/.config/help/help_pacman.txt'
alias help-loginctl='cat ~/.config/help/help_loginctl.txt'
alias help-mysql='cat ~/.config/help/help_mysql.txt'

echo
if command -v fastfetch >/dev/null; then
    fastfetch --separator " - "
fi

eval "$(starship init bash)"

[ -f "$HOME/.cache/wal/colors.sh" ] && source "$HOME/.cache/wal/colors.sh"