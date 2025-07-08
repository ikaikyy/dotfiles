-- Formatting configuration using conform.nvim
local conform = require("conform")

-- Check if nixCats categories are available
local function has_category(category)
  if nixCats then
    return nixCats(category) ~= nil
  end
  return true -- fallback to true if nixCats is not available
end

conform.setup({
  formatters_by_ft = {
    -- TypeScript/JavaScript
    javascript = has_category('typescript') and { "prettierd", "prettier" } or nil,
    typescript = has_category('typescript') and { "prettierd", "prettier" } or nil,
    javascriptreact = has_category('typescript') and { "prettierd", "prettier" } or nil,
    typescriptreact = has_category('typescript') and { "prettierd", "prettier" } or nil,
    
    -- Web
    html = has_category('web') and { "prettierd", "prettier" } or nil,
    css = has_category('web') and { "prettierd", "prettier" } or nil,
    scss = has_category('web') and { "prettierd", "prettier" } or nil,
    json = has_category('web') and { "prettierd", "prettier" } or nil,
    yaml = has_category('web') and { "prettierd", "prettier" } or nil,
    markdown = has_category('web') and { "prettierd", "prettier" } or nil,
    
    -- PHP
    php = has_category('php') and { "prettierd", "prettier" } or nil,
    blade = has_category('php') and { "blade-formatter" } or nil,
    
    -- Python
    python = has_category('python') and { "black", "isort" } or nil,
    
    -- Rust
    rust = has_category('rust') and { "rustfmt" } or nil,
    
    -- C/C++
    c = has_category('c') and { "clang_format" } or nil,
    cpp = has_category('c') and { "clang_format" } or nil,
    
    -- Lua
    lua = has_category('lua') and { "stylua" } or nil,
    
    -- Nix
    nix = has_category('nix') and { "nixfmt" } or nil,
    
    -- Shell
    sh = has_category('format') and { "shfmt" } or nil,
    bash = has_category('format') and { "shfmt" } or nil,
    zsh = has_category('format') and { "shfmt" } or nil,
    
    -- Go
    go = has_category('go') and { "gofmt" } or nil,
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