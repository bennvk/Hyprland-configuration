vim.opt.number = true
vim.opt.clipboard = "unnamedplus"

vim.o.mouse = "a"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.g.mapleader = " "

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.keymap.set({'n', 'v'}, '<C-Down>', '}')
vim.keymap.set({'n', 'v'}, '<C-Up>', '{')
vim.keymap.set({'n', 'v'}, 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('v', 'P', '"_dP')
vim.keymap.set({'n', 'v'}, 'c', '"_c')

vim.api.nvim_create_user_command("W", "SudaWrite", {})
vim.api.nvim_create_user_command("Wq", function()
  vim.cmd("SudaWrite")
  vim.cmd("q")
end, {})

-- Lazyvim install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")

-- Plugins source
require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { import = "plugins" },
})

-- Themes sources
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("themes.pywal").setup()
    require("themes.lualine").setup()
  end,
})
