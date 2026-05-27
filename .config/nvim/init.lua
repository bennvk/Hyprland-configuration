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

vim.keymap.set({'n', 'v'}, 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')

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
require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("themes.pywal").setup()
    require("themes.lualine").setup()
  end,
})
