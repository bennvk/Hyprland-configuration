local M = {}

function M.get_pywal_colors()
  local file = io.open(vim.fn.expand("~/.cache/wal/colors.json"), "r")
  if not file then return nil end
  local json = file:read("*a")
  file:close()
  local data = vim.fn.json_decode(json)
  return {
    background = data.special.background,
    foreground = data.special.foreground,
    cursor     = data.special.cursor,
    color0  = data.colors.color0,
    color1  = data.colors.color1,
    color2  = data.colors.color2,
    color3  = data.colors.color3,
    color4  = data.colors.color4,
    color5  = data.colors.color5,
    color6  = data.colors.color6,
    color7  = data.colors.color7,
    color8  = data.colors.color8,
    color9  = data.colors.color9,
    color10 = data.colors.color10,
    color11 = data.colors.color11,
    color12 = data.colors.color12,
    color13 = data.colors.color13,
    color14 = data.colors.color14,
    color15 = data.colors.color15,
  }
end

function M.setup()
  local colors = M.get_pywal_colors()
  if not colors then return end

  local set = vim.cmd

  -- Core UI
  set("highlight Normal guibg=" .. colors.background .. " guifg=" .. colors.foreground)
  set("highlight NormalNC guibg=" .. colors.background)
  set("highlight CursorLine guibg=" .. colors.color0)
  set("highlight CursorLineNr guifg=" .. colors.color2 .. " gui=bold")
  set("highlight LineNr guifg=" .. colors.color8)
  set("highlight MatchParen guibg=" .. colors.color0 .. " guifg=" .. colors.color4 .. " gui=bold")
  set("highlight Visual guibg=" .. colors.color0)

  -- Text/Syntax
  set("highlight Comment guifg=" .. colors.color8 .. " gui=italic")
  set("highlight Constant guifg=" .. colors.color5)
  set("highlight String guifg=" .. colors.color2)
  set("highlight Character guifg=" .. colors.color2)
  set("highlight Number guifg=" .. colors.color1)
  set("highlight Boolean guifg=" .. colors.color1)
  set("highlight Float guifg=" .. colors.color1)
  set("highlight Identifier guifg=" .. colors.color4)
  set("highlight Function guifg=" .. colors.color4 .. " gui=bold")
  set("highlight Statement guifg=" .. colors.color1)
  set("highlight Conditional guifg=" .. colors.color3)
  set("highlight Repeat guifg=" .. colors.color3)
  set("highlight Keyword guifg=" .. colors.color3)
  set("highlight Operator guifg=" .. colors.color6)
  set("highlight PreProc guifg=" .. colors.color5)
  set("highlight Type guifg=" .. colors.color6)
  set("highlight Special guifg=" .. colors.color13)
  set("highlight Underlined guifg=" .. colors.color12 .. " gui=underline")

  -- UI components
  set("highlight StatusLine guibg=" .. colors.color0 .. " guifg=" .. colors.color7)
  set("highlight VertSplit guifg=" .. colors.color0)
  set("highlight Pmenu guibg=" .. colors.color0 .. " guifg=" .. colors.color7)
  set("highlight PmenuSel guibg=" .. colors.color2 .. " guifg=" .. colors.background)
  set("highlight Search guibg=" .. colors.color3 .. " guifg=" .. colors.background)
  set("highlight IncSearch guibg=" .. colors.color1 .. " guifg=" .. colors.background)

  -- Diagnostic (LSP)
  set("highlight DiagnosticError guifg=" .. colors.color1)
  set("highlight DiagnosticHint guifg=" .. colors.color6)
end

return M
