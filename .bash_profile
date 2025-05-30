#
# ~/.bash_profile
#

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec Hyprland

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Created by `pipx` on 2025-05-10 14:31:55
export PATH="$PATH:/home/benn/.local/bin"

export WLR_NO_HARDWARE_CURSORS=1
export WLR_DRM_ATOMIC=1
exec hyprland
