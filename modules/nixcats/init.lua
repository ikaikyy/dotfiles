-- nixCats: this is where we define some arguments to the nixCats lua

-- nixCats is a lua table that contains the outputs of the nix functions
-- that were passed to it in the Lua wrap script.
-- It will be accessible anywhere in our config.

-- This includes what packages to download, which LSPs to enable, etc.

-- First, set up basic vim options
require('config.options')

-- Set up keymaps
require('config.keymaps')

-- Set up autocommands
require('config.autocmds')

-- Load colorscheme
require('config.colorscheme')

-- Set up plugins
require('config.plugins')