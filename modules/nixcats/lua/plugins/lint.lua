-- Linting configuration using nvim-lint
local lint = require('lint')

-- Configure linters by filetype
lint.linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  python = { 'pylint' },
  php = { 'phpcs' },
  lua = { 'luacheck' },
  sh = { 'shellcheck' },
  bash = { 'shellcheck' },
  zsh = { 'shellcheck' },
}

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