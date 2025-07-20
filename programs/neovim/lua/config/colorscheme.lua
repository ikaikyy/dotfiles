-- Colorscheme configuration
-- Check if gruvbox is available and set it up
local function setup_gruvbox()
  local ok, gruvbox = pcall(require, "gruvbox")
  if not ok then
    vim.notify("Gruvbox colorscheme not found", vim.log.levels.WARN)
    return false
  end

  gruvbox.setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
  })

  vim.cmd("colorscheme gruvbox")
  return true
end

-- Try to set up gruvbox, fallback to default if not available
if not setup_gruvbox() then
  vim.cmd("colorscheme default")
  vim.notify("Using default colorscheme", vim.log.levels.INFO)
end