-- LSP Configuration
local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Check if nixCats categories are available
local function has_category(category)
  if nixCats then
    return nixCats(category) ~= nil
  end
  return true -- fallback to true if nixCats is not available
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- LSP settings
local function on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Buffer local mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end

-- Common LSP settings
local default_config = {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- TypeScript/JavaScript
if has_category('lspsAndRuntimeDeps') then
  lspconfig.ts_ls.setup(default_config)
  
  -- ESLint
  lspconfig.eslint.setup(vim.tbl_extend('force', default_config, {
    settings = {
      workingDirectory = { mode = "location" },
    },
  }))
end

-- Python
if has_category('lspsAndRuntimeDeps') then
  lspconfig.pylsp.setup(vim.tbl_extend('force', default_config, {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = {'W391'},
            maxLineLength = 100
          },
          pydocstyle = {
            enabled = false
          },
          yapf = {
            enabled = false
          },
          autopep8 = {
            enabled = false
          },
          black = {
            enabled = true
          },
        }
      }
    }
  }))
end

-- PHP
if has_category('lspsAndRuntimeDeps') then
  lspconfig.intelephense.setup(default_config)
end

-- Rust
if has_category('lspsAndRuntimeDeps') then
  lspconfig.rust_analyzer.setup(vim.tbl_extend('force', default_config, {
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
      }
    }
  }))
end

-- HTML, CSS, JSON
if has_category('lspsAndRuntimeDeps') then
  lspconfig.html.setup(default_config)
  lspconfig.cssls.setup(default_config)
  lspconfig.jsonls.setup(default_config)
end

-- Lua
if has_category('lspsAndRuntimeDeps') then
  lspconfig.lua_ls.setup(vim.tbl_extend('force', default_config, {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {'vim', 'nixCats'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }))
end

-- Nix
if has_category('lspsAndRuntimeDeps') then
  lspconfig.nil_ls.setup(default_config)
end

-- Go
if has_category('lspsAndRuntimeDeps') then
  lspconfig.gopls.setup(default_config)
end

-- C/C++
if has_category('lspsAndRuntimeDeps') then
  lspconfig.clangd.setup(default_config)
end

-- HTMX
if has_category('lspsAndRuntimeDeps') then
  lspconfig.htmx.setup(default_config)
end

-- Markdown
if has_category('lspsAndRuntimeDeps') then
  lspconfig.markdown_oxide.setup(default_config)
end

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Set up diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end