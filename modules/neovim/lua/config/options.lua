-- Basic vim options configuration
local opt = vim.opt

-- Basic editing
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Visual
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Clipboard
opt.clipboard = "unnamedplus"

-- Undo
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Update time
opt.updatetime = 50

-- Disable netrw (we'll use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
