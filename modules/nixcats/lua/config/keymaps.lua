-- Keymaps configuration
local keymap = vim.keymap

-- Save buffer
keymap.set("n", "<leader>sv", "<Cmd>w<CR>", { desc = "Save buffer" })

-- Clear search highlight
keymap.set("n", "<Esc>", "<Cmd>noh<CR>", { desc = "Clear search highlight" })

-- File explorer
keymap.set("n", "<leader>pv", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })

-- Formatting
keymap.set({ "n", "v" }, "<leader>fmt", function()
  vim.lsp.buf.format({ async = false })
end, { desc = "Format buffer" })

-- Trouble diagnostics
keymap.set("n", "<leader>td", "<Cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>", { desc = "Toggle buffer diagnostics" })
keymap.set("n", "<leader>tD", "<Cmd>Trouble diagnostics toggle focus=true<CR>", { desc = "Toggle workspace diagnostics" })

-- Telescope
keymap.set("n", "<leader>ff", "<Cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<Cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- LSP keymaps (will be set up in LSP config)
keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover documentation" })
keymap.set("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })
keymap.set("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
keymap.set("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })
keymap.set("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", { desc = "Go to references" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", { desc = "Move text down" })
keymap.set("v", "<A-k>", ":m .-2<CR>==", { desc = "Move text up" })
keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move text down" })
keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move text up" })

-- Buffer navigation
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })