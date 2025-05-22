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

echo; command -v fastfetch >/dev/null && fastfetch;

# Created by `pipx` on 2025-05-10 14:31:55
export PATH="$PATH:/home/benn/.local/bin"

eval "$(starship init bash)"
