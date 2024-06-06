vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.cmdheight = 0

vim.cmd([[
  augroup hideCmdline
    autocmd!
    autocmd CmdlineEnter * setlocal cmdheight=1
    autocmd CmdlineLeave * setlocal cmdheight=0
  augroup END
]])
