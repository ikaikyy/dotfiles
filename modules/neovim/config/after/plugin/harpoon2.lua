local harpoon = require('harpoon')

harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
    initial_mode = "normal",
  }):find()
end

-- Keymaps
vim.keymap.set("n", "<leader>ahp", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>chp", function() harpoon:list():clear() end)
vim.keymap.set("n", "<leader>rhp", function() harpoon:list():remove() end)

vim.keymap.set("n", "<leader>hp", function() toggle_telescope(harpoon:list()) end,
  { desc = "Open harpoon window" })
