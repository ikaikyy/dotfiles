-- Telescope configuration
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		path_display = { "truncate" },
		file_ignore_patterns = {
			"%.git/",
			"node_modules/",
			"%.next/",
			"dist/",
			"build/",
			"target/",
			"%.cargo/",
		},

		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
			n = {
				["<esc>"] = actions.close,
			},
		},
	},

	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
			hidden = true,
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
			initial_mode = "normal",
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
	},
})
