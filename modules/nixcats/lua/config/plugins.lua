-- Main plugins configuration with lze
-- This is where we set up all our plugins with proper lazy loading

-- Check if nixCats categories are available
local function has_category(category)
  if nixCats then
    return nixCats(category) ~= nil
  end
  return true -- fallback to true if nixCats is not available
end

-- Only proceed if we have the startup plugins
if not has_category('general') then
  return
end

-- Set up gruvbox colorscheme first
vim.cmd.colorscheme('gruvbox')

-- Configure lze (the nixCats lazy loader)
require('lze').load {
  -- LSP Configuration
  {
    "nvim-lspconfig",
    enabled = has_category('general') or false,
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("plugins.lsp")
    end,
  },

  -- Completion
  {
    "nvim-cmp",
    enabled = has_category('general') or false,
    event = "InsertEnter",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("cmp-nvim-lsp")
      vim.cmd.packadd("cmp-buffer")
      vim.cmd.packadd("cmp-path")
      vim.cmd.packadd("luasnip")
      vim.cmd.packadd("cmp_luasnip")
      vim.cmd.packadd("friendly-snippets")
    end,
    after = function()
      require("plugins.cmp")
    end,
  },

  -- File explorer
  {
    "nvim-tree.lua",
    enabled = has_category('general') or false,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
    keys = {
      { "<leader>pv", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-web-devicons")
    end,
    after = function()
      require("plugins.nvim-tree")
    end,
  },

  -- Telescope
  {
    "telescope.nvim",
    enabled = has_category('general') or false,
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("plenary.nvim")
    end,
    after = function()
      require("plugins.telescope")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter",
    enabled = has_category('general') or false,
    event = { "BufReadPost", "BufNewFile" },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-treesitter-textobjects")
    end,
    after = function()
      require("plugins.treesitter")
    end,
  },

  -- Formatting
  {
    "conform.nvim",
    enabled = has_category('format') or false,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>FF", desc = "Format file" },
    },
    after = function()
      require("plugins.conform")
    end,
  },

  -- Linting
  {
    "nvim-lint",
    enabled = has_category('format') or false,
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("plugins.lint")
    end,
  },

  -- Status line
  {
    "lualine.nvim",
    enabled = has_category('general') or false,
    event = "VeryLazy",
    after = function()
      require("plugins.lualine")
    end,
  },

  -- Trouble diagnostics
  {
    "trouble.nvim",
    enabled = has_category('general') or false,
    cmd = { "Trouble" },
    keys = {
      { "<leader>td", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>tD", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Workspace Diagnostics (Trouble)" },
    },
    after = function()
      require("plugins.trouble")
    end,
  },

  -- Git integration
  {
    "gitsigns.nvim",
    enabled = has_category('general') or false,
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("plugins.gitsigns")
    end,
  },

  -- Copilot
  {
    "copilot.lua",
    enabled = has_category('general') or false,
    cmd = "Copilot",
    event = "InsertEnter",
    after = function()
      require("plugins.copilot")
    end,
  },

  -- Alpha dashboard
  {
    "alpha-nvim",
    enabled = has_category('general') or false,
    event = "VimEnter",
    after = function()
      require("plugins.alpha")
    end,
  },

  -- Markdown preview
  {
    "markdown-preview.nvim",
    enabled = has_category('general') or false,
    ft = "markdown",
    before = function()
      vim.fn["mkdp#util#install"]()
    end,
    after = function()
      require("plugins.markdown-preview")
    end,
  },

  -- Comment
  {
    "comment.nvim",
    enabled = has_category('general') or false,
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    after = function()
      require("Comment").setup()
    end,
  },

  -- Auto pairs
  {
    "nvim-autopairs",
    enabled = has_category('general') or false,
    event = "InsertEnter",
    after = function()
      require("plugins.autopairs")
    end,
  },

  -- Surround
  {
    "nvim-surround",
    enabled = has_category('general') or false,
    event = "VeryLazy",
    after = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Which-key for keybinding hints
  {
    "which-key.nvim",
    enabled = has_category('general') or false,
    event = "VeryLazy",
    before = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    after = function()
      require("which-key").setup({})
    end,
  },

  -- Buffer line
  {
    "bufferline.nvim",
    enabled = has_category('general') or false,
    event = "VeryLazy",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-web-devicons")
    end,
    after = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              separator = true
            }
          },
        }
      })
    end,
  },
}