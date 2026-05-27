local function get_wal_colors()
  local path = vim.fn.expand("~/.cache/wal/colors.json")
  local file = io.open(path, "r")
  if not file then
    return {
      special = { background = "#1a1a2e", foreground = "#ffffff", cursor = "#ffffff" },
      colors  = {
        color0 = "#1a1a2e", color1 = "#e94560", color2 = "#0f3460",
      },
    }
  end
  local content = file:read("*a")
  file:close()
  return vim.fn.json_decode(content)
end

local M = {}

function M.setup()
  local wal = get_wal_colors()

  local colors = {
    bg     = wal.special.background,
    fg     = wal.special.foreground,
    color0 = wal.colors.color0,
    color1 = wal.colors.color1,
    color2 = wal.colors.color2,
  }

  local theme = {
    normal  = {
      a = { fg = colors.fg, bg = colors.color1, gui = "bold" },
      b = { fg = colors.fg, bg = colors.color2 },
      c = { fg = colors.fg, bg = colors.color0 },
    },
    insert  = {
      a = { fg = colors.fg, bg = colors.color1, gui = "bold" },
    },
    visual  = {
      a = { fg = colors.fg, bg = colors.color1, gui = "bold" },
    },
    replace = {
      a = { fg = colors.fg, bg = colors.color1, gui = "bold" },
    },
    inactive = {
      a = { fg = colors.fg, bg = colors.color0 },
      b = { fg = colors.fg, bg = colors.color0 },
      c = { fg = colors.fg, bg = colors.color0 },
    },
  }

  require("lualine").setup({
    options = {
      theme = theme,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "filename", "filesize" },
      lualine_c = {},
      lualine_x = {},
      lualine_y = { "location" },
      lualine_z = { "progress" },
    }
  })
end

return M
