require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  styles = {
    keywords = { "bold" },
    functions = { "italic" },
  },
  integrations = {
    cmp = true,
    lsp_trouble = true,
    mason = true,
    nvimtree = true,
    telescope = {
      enabled = true,
    },
    treesitter = true,
  },
  color_overrides = {
    mocha = {
      red = "#f07c82",
      blue = "#70a1ff",
      green = "#7bed9f",
      yellow = "#ffeaa7",

      sky = "#5ef1ff",
      pink = "#ffacfc",
      peach = "#ffbe76",
    },
  },
})

vim.cmd.colorscheme("catppuccin")
