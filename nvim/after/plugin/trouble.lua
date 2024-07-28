local trouble = require("trouble")

-- Keymaps
vim.keymap.set("n", "<leader>td", function()
  trouble.toggle("diagnostics")
end)
