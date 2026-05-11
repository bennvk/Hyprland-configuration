
--            _           _                            __                         _                                  
--  __      _(_)_ __   __| | _____      _____       /\ \ \    __      _____  _ __| | _____ _ __   __ _  ___ ___  ___ 
--  \ \ /\ / / | '_ \ / _` |/ _ \ \ /\ / / __|     /  \/ /    \ \ /\ / / _ \| '__| |/ / __| '_ \ / _` |/ __/ _ \/ __|
--   \ V  V /| | | | | (_| | (_) \ V  V /\__ \    / /\  /      \ V  V / (_) | |  |   <\__ \ |_) | (_| | (_|  __/\__ \
--    \_/\_/ |_|_| |_|\__,_|\___/ \_/\_/ |___/    \_\ \/        \_/\_/ \___/|_|  |_|\_\___/ .__/ \__,_|\___\___||___/
--                                                                                      |_|                        

--local func = require("modules-lua/functions") 

-- Workspaces 

--func.assign_workspaces() 
--  hl.on("monitor.added", function(_) func.assign_workspaces() 
--end) 
--  hl.on("monitor.removed", function(_) func.assign_workspaces() 
--end) 

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
