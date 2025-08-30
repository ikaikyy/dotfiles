-- Keymaps configuration
local keymap = vim.keymap

-- Save buffer
keymap.set("n", "<leader>sv", "<Cmd>w<CR>", { desc = "Save buffer" })

-- Clear search highlight
keymap.set("n", "<Esc>", "<Cmd>noh<CR>", { desc = "Clear search highlight" })

-- Formatting
keymap.set({ "n", "v" }, "<leader>fmt", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
