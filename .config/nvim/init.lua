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
vim.opt.statusline = " %f %r %=%l:%c | %p%% "
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("themes.pywal").setup()
  end,
})
