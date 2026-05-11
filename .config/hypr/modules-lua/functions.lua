local M = {}

M.TOTAL_WORKSPACES = 6
M.IGNORED_MONITORS = { "" }

function M.assign_workspaces()
    local monitors = hl.get_monitors()

    for _, m in ipairs(all_monitors) do
        local ignored = false
        for _, name in ipairs(M.IGNORED_MONITORS) do
            if m.name == name then ignored = true; break end
        end
        if not ignored then
            table.insert(monitors, m)
        end
    end

    local total_monitors = #monitors
    if total_monitors == 0 then return end

    local workspaces_per_monitor = math.floor(M.TOTAL_WORKSPACES / total_monitors)
    local idx = 1

    for i, m in ipairs(monitors) do
        local nb = (i == total_monitors) and (M.TOTAL_WORKSPACES - idx + 1) or workspaces_per_monitor

        for w = 0, nb - 1 do
            local ws = idx + w
            hl.workspace_rule({
                workspace  = tostring(ws),
                monitor    = m.name,
                persistent = true,
            })
            hl.dispatch(hl.dsp.workspace.move_to_monitor({
                workspace = tostring(ws),
                monitor   = m.name,
            }))
        end

        idx = idx + nb
    end
end

return M