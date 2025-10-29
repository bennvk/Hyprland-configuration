# ~/.bash_profile

export PATH="$PATH:/home/benn/.local/bin"
export LANG=fr_FR.UTF-8

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    echo "Lancement de Hyprland..."
    exec Hyprland
fi