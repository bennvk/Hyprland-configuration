export PATH="$PATH:/home/benn/.local/bin"
export LANG=fr_FR.UTF-8

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec start-hyprland
fi
