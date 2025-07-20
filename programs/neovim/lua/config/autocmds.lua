-- Autocommands configuration
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings
local general = augroup("General", { clear = true })

-- Command line height management
local cmdline = augroup("CmdlineHeight", { clear = true })

autocmd("CmdlineEnter", {
  group = cmdline,
  pattern = "*",
  command = "setlocal cmdheight=1",
})

autocmd("CmdlineLeave", {
  group = cmdline,
  pattern = "*",
  command = "setlocal cmdheight=0",
})

-- Format on save
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
