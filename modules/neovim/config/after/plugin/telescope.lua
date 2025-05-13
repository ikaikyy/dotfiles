local telescoptActions = require("telescope.actions")
local telescopeBuiltin = require("telescope/builtin")

require("telescope").setup({
  defaults = {
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    mappings = {
      i = {
        ["<esc>"] = telescoptActions.close,
      },
    },
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescopeBuiltin.live_grep, {})
