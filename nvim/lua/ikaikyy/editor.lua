vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

-- Make background transparent

local groups = {
  'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
  'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
  'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
  'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
  'EndOfBuffer', 'NvimTreeNormal', 'NvimTreeNormalNC', 'NvimTreeSignColumn', 'NvimTreeWinSeparator',
}

for _, group in ipairs(groups) do
  vim.cmd('hi! ' .. group .. ' guibg=NONE ctermbg=NONE')
end
