-- Linting configuration using nvim-lint
local lint = require('lint')

-- Check if nixCats categories are available
local function has_category(category)
  if nixCats then
    return nixCats(category) ~= nil
  end
  return true -- fallback to true if nixCats is not available
end

-- Configure linters by filetype based on enabled categories
local linters_by_ft = {}

if has_category('typescript') then
  linters_by_ft.javascript = { 'eslint_d' }
  linters_by_ft.typescript = { 'eslint_d' }
  linters_by_ft.javascriptreact = { 'eslint_d' }
  linters_by_ft.typescriptreact = { 'eslint_d' }
end

if has_category('python') then
  linters_by_ft.python = { 'pylint' }
end

if has_category('php') then
  linters_by_ft.php = { 'phpcs' }
end

if has_category('lua') then
  linters_by_ft.lua = { 'luacheck' }
end

if has_category('format') then
  linters_by_ft.sh = { 'shellcheck' }
  linters_by_ft.bash = { 'shellcheck' }
  linters_by_ft.zsh = { 'shellcheck' }
end

lint.linters_by_ft = linters_by_ft

-- Custom lint function
local function lint_file()
  lint.try_lint()
end

-- Autocommands for linting
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = lint_file,
})

-- Manual lint keymap
vim.keymap.set("n", "<leader>l", lint_file, { desc = "Trigger linting for current file" })