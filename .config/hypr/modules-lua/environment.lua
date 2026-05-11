
--                   _                                      _   
--    ___ _ ____   _(_)_ __ ___  _ __  _ __ ___   ___ _ __ | |_ 
--   / _ \ '_ \ \ / / | '__/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
--  |  __/ | | \ V /| | | | (_) | | | | | | | | |  __/ | | | |_ 
--   \___|_| |_|\_/ |_|_|  \___/|_| |_|_| |_| |_|\___|_| |_|\__|
--                                                            

hl.env("EDITOR", "nvim")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("WLR_RENDERER", "vulkan")
hl.env("WLR_DRM_ATOMIC", "1")

hl.env("HYPRLAND_CONFIG", "/home/benn/.config/hypr/hyprland.lua")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
