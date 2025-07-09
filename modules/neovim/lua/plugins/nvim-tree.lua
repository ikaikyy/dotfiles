require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 40,
		side = "left",
	},
	renderer = {
		group_empty = false,
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 400,
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		debounce_delay = 50,
	},
})
