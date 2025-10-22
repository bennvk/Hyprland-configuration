# ~/.bash_profile

export PATH="$PATH:/home/benn/.local/bin"
export LANG=fr_FR.UTF-8
export XDG_SESSION_TYPE=wayland
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export __GL_GSYNC_ALLOWED=1
export __GL_VRR_ALLOWED=1
export WLR_NO_HARDWARE_CURSORS=1
export WLR_DRM_ATOMIC=1
export WLR_RENDERER=vulkan

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec Hyprland