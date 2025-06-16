require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom",
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = false,
    debounce = 75,
    keymap = {
      accept = "<C-p>",
      accept_word = false,
      accept_line = false,
      next = "<C-]>",
      prev = "<C-[>",
      dismiss = "<esc>",
    },
  },
  filetypes = {
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node',
  server_opts_overrides = {},
})

local chat = require('CopilotChat')
local select = require('CopilotChat.select')

chat.setup({
  debug = false,
  references_display = 'write',
  selection = select.visual,
  sticky = {
    '#buffers',
  },
  mappings = {
    reset = {
      normal = '',
      insert = '',
    },
    show_diff = {
      full_diff = true,
    },
  },
  prompts = {
    Explain = {
      mapping = '<leader>ae',
      description = 'AI Explain',
    },
    Review = {
      mapping = '<leader>ar',
      description = 'AI Review',
    },
    Tests = {
      mapping = '<leader>at',
      description = 'AI Tests',
    },
    Fix = {
      mapping = '<leader>af',
      description = 'AI Fix',
    },
    Optimize = {
      mapping = '<leader>ao',
      description = 'AI Optimize',
    },
    Docs = {
      mapping = '<leader>ad',
      description = 'AI Documentation',
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>ac', '<cmd>lua require("CopilotChat").toggle()<CR>',
  { noremap = true, silent = true })
