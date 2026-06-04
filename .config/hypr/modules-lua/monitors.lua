
--                           _                 
--   _ __ ___   ___  _ __ (_) |_ ___  _ __ ___ 
--  | '_ ` _ \ / _ \| '_ \| | __/ _ \| '__/ __|
--  | | | | | | (_) | | | | | || (_) | |  \__ \
--  |_| |_| |_|\___/|_| |_|_|\__\___/|_|  |___/
--   

hl.monitor({ output = "eDP-1", mode = "highres@highrr", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "highres@highrr", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "1920x1080", position = "1920x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080", position = "3840x0", scale = 1 })
hl.monitor({ output = "DP-4", mode = "1920x1080", position = "5760x0", scale = 1 })

hl.monitor({ output = "HDMI-A-1", mode = "highres@highrr", scale = 1 , mirror = "eDP-1"})
