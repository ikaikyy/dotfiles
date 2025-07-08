-- Formatting configuration using conform.nvim
local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- TypeScript/JavaScript
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    
    -- Web
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    
    -- PHP
    php = { "prettierd", "prettier" },
    blade = { "blade-formatter" },
    
    -- Python
    python = { "black", "isort" },
    
    -- Rust
    rust = { "rustfmt" },
    
    -- C/C++
    c = { "clang_format" },
    cpp = { "clang_format" },
    
    -- Lua
    lua = { "stylua" },
    
    -- Nix
    nix = { "nixfmt" },
    
    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    
    -- Go
    go = { "gofmt" },
  },
  
  -- Format on save
  format_on_save = function(bufnr)
    -- Disable format on save for certain file types
    local disable_filetypes = { c = true, cpp = true }
    return {
      timeout_ms = 500,
      lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    }
  end,
  
  -- Custom formatters
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },
})

-- Keymap for manual formatting
vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format file or range (in visual mode)" })