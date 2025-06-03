vim.opt.number = true

vim.o.mouse = "a"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("themes.pywal").setup()
  end,
})
