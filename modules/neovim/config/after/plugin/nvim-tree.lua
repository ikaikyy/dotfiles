vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  git = {
    ignore = false,
  }
})

local function toggle_nvim_tree()
  require("nvim-tree.api").tree.toggle({
    path = nil,
    current_window = false,
    find_file = false,
    update_root = false,
    focus = true,
  })
end

vim.keymap.set("n", "<leader>pv", toggle_nvim_tree, { noremap = true, silent = true })
