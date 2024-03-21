local telescopeBuiltin = require("telescope/builtin")

-- Keymaps
vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescopeBuiltin.live_grep, {})
