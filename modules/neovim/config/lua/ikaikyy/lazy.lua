local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  "nvim-treesitter/nvim-treesitter",
  { "catppuccin/nvim",       name = "catppuccin" },
  "rstacruz/vim-closer",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "VonHeikemen/lsp-zero.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "mfussenegger/nvim-dap",
  "stevearc/conform.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "folke/trouble.nvim",
  "MunifTanjim/nui.nvim",
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
  },
  "nvim-lualine/lualine.nvim",
  { "zbirenbaum/copilot.lua" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
  },
  { 'AndreM222/copilot-lualine' },
})
