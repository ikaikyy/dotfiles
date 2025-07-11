local function has_category(category)
	if nixCats then
		return nixCats(category) ~= nil
	end
	return true
end

if not has_category("general") then
	return
end

vim.cmd.colorscheme("gruvbox")
vim.g.coq_settings = { auto_start = true }

require("lze").register_handlers(require("lzextras").lsp)
require("lze").load({
	-- LSP Configuration
	{
		"nvim-lspconfig",
		enabled = has_category("general") or false,
		event = "DeferredUIEnter",
		lsp = function(plugin)
			vim.lsp.config(plugin.name, plugin.lsp or {})
			vim.lsp.enable(plugin.name)
		end,
		before = function()
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				on_attach = function(client, bufnr)
					local bufopts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
					vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
					vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, bufopts)
					vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, bufopts)
				end,
				capabilities,
			})
		end,
	},
	{
		"ts_ls",
		enabled = has_category("typescript") or false,
		lsp = {},
	},
	{
		"pylsp",
		enabled = has_category("python") or false,
		lsp = {
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							ignore = { "W391" },
							maxLineLength = 100,
						},
						pydocstyle = {
							enabled = false,
						},
						yapf = {
							enabled = false,
						},
						autopep8 = {
							enabled = false,
						},
						black = {
							enabled = true,
						},
					},
				},
			},
		},
	},
	{
		"intelephense",
		enabled = has_category("php") or false,
		lsp = {},
	},
	{
		"rust_analyzer",
		enabled = has_category("rust") or false,
		lsp = {},
	},
	{
		"html",
		enabled = has_category("web") or false,
		lsp = {},
	},
	{
		"cssls",
		enabled = has_category("web") or false,
		lsp = {},
	},
	{
		"jsonls",
		enabled = has_category("web") or false,
		lsp = {},
	},
	{
		"htmx",
		enabled = has_category("web") or false,
		lsp = {},
	},
	{
		"markdown_oxide",
		enabled = has_category("web") or false,
		lsp = {},
	},
	{
		"lua_ls",
		enabled = has_category("lua") or false,
		lsp = {
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim", "nixCats" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		},
	},

	{
		"nil_ls",
		enabled = has_category("nix") or false,
		lsp = {},
	},
	{
		"gopls",
		enabled = has_category("go") or false,
		lsp = {},
	},
	{
		"clangd",
		enabled = has_category("c") or false,
		lsp = {},
	},

	-- Completion
	{
		"nvim-cmp",
		enabled = has_category("general") or false,
		event = "InsertEnter",
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("cmp-nvim-lsp")
			vim.cmd.packadd("cmp-buffer")
			vim.cmd.packadd("cmp-path")
			vim.cmd.packadd("copilot")
			vim.cmd.packadd("copilot_cmp")
			vim.cmd.packadd("lspkind")
		end,
		after = function()
			require("plugins.copilot")
			require("plugins.cmp")
		end,
	},

	-- Null-ls
	{
		"none-ls.nvim",
		enabled = has_category("general") or false,
		dep_of = "nvim-lspconfig",
		after = function()
			require("plugins.null-ls")
		end,
	},

	-- File explorer
	{
		"nvim-tree.lua",
		enabled = has_category("general") or false,
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus" },
		keys = {
			{ "<leader>pv", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
		},
		after = function()
			require("plugins.nvim-tree")
		end,
	},

	-- Telescope
	{
		"telescope.nvim",
		enabled = has_category("general") or false,
		event = "DeferredUIEnter",
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
		enabled = has_category("general") or false,
		event = { "BufEnter" },
		after = function()
			require("plugins.treesitter")
		end,
	},

	-- Status line
	{
		"lualine.nvim",
		enabled = has_category("general") or false,
		event = "DeferredUIEnter",
		after = function()
			require("plugins.lualine")
		end,
	},

	-- Trouble diagnostics
	{
		"trouble.nvim",
		enabled = has_category("general") or false,
		cmd = { "Trouble" },
		keys = {
			{
				"<leader>td",
				"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>tw",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Workspace Diagnostics (Trouble)",
			},
		},
		after = function()
			require("trouble").setup({
				keys = {
					["<esc>"] = "cancel",
					["<cr>"] = "jump_close",
				},
			})
		end,
	},

	-- Git integration
	{
		"gitsigns.nvim",
		enabled = has_category("general") or false,
		event = { "BufEnter" },
		after = function()
			require("plugins.gitsigns")
		end,
	},

	-- Alpha dashboard
	{
		"alpha-nvim",
		enabled = has_category("general") or false,
		event = "VimEnter",
		after = function()
			require("plugins.alpha")
		end,
	},

	-- Markdown preview
	{
		"markdown-preview.nvim",
		enabled = has_category("general") or false,
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
		enabled = has_category("general") or false,
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
		enabled = has_category("general") or false,
		event = "InsertEnter",
		after = function()
			require("plugins.autopairs")
		end,
	},
})
