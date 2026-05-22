
--            _           _                            __                         _                                  
--  __      _(_)_ __   __| | _____      _____       /\ \ \    __      _____  _ __| | _____ _ __   __ _  ___ ___  ___ 
--  \ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __|     /  \/ /    \ \ /\ / / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
--   \ V  V /| | | | | (_| | (_) \ V  V /\__ \    / /\  /      \ V  V / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
--    \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/    \_\ \/        \_/\_/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
--                                                                                      |_|                        

-- Workspaces

hl.workspace_rule({workspace = "1", monitor = "eDP-1", default = true})
hl.workspace_rule({workspace = "2", monitor = "eDP-1"})
hl.workspace_rule({workspace = "3", monitor = "eDP-1"})
hl.workspace_rule({workspace = "4", monitor = "DP-1", default = true})
hl.workspace_rule({workspace = "5", monitor = "DP-1"})
hl.workspace_rule({workspace = "6", monitor = "DP-1"})

-- Windows 

hl.window_rule({ 
  match = { class = "galculator" }, 
  float = true, 
  size = {375, 500} 
}) 

hl.window_rule({ 
  match = { class = "swayimg" }, 
  float = true, 
  size = {1000, 550} 
})

hl.window_rule({ 
  match = { class = "xdg-desktop-portal-gtk" }, 
  float = true, 
  size = {1250, 800} 
})
