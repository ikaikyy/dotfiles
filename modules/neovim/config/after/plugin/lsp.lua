local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "clangd",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "htmx",
    "jsonls",
    "lua_ls",
    "intelephense",
    "rust_analyzer",
    "tsserver",
    "kotlin_language_server",
    "nil",
    "nixfmt",
  },
  handlers = {
    lsp_zero.default_setup,
  },
})
