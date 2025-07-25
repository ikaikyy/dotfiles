local null_ls = require("null-ls")

-- Check if nixCats categories are available
local function has_category(category)
  if nixCats then
    return nixCats(category) ~= nil
  end
  return true -- fallback to true if nixCats is not available
end

-- code action sources
local code_actions = null_ls.builtins.code_actions

-- diagnostic sources
local diagnostics = null_ls.builtins.diagnostics

-- formatting sources
local formatting = null_ls.builtins.formatting

-- hover sources
local hover = null_ls.builtins.hover

-- completion sources
local completion = null_ls.builtins.completion

local sources = {
  -- Web
  has_category("web") and formatting.prettierd or nil,
  has_category("web") and formatting.rustywind or nil,

  -- PHP
  has_category("php") and formatting.pretty_php or nil,
  has_category("php") and formatting.blade_formatter or nil,

  -- Python
  has_category("python") and formatting.black or nil,

  -- Rust
  has_category("rust") and formatting.dxfmt or nil,

  -- C/C++
  has_category("c") and formatting.clang_format or nil,

  -- Lua
  has_category("lua") and formatting.stylua or nil,

  -- Nix
  has_category("nix") and formatting.alejandra or nil,

  -- Shell
  has_category("shell") and formatting.shfmt or nil,

  -- Go
  has_category("go") and formatting.gofmt or nil,
}

null_ls.setup({ sources = sources })
