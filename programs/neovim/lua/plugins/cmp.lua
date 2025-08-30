-- Completion configuration
local cmp = require("cmp")
local copilot_cmp = require("copilot_cmp")
local lspkind = require("lspkind")

copilot_cmp.setup()

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				path = "[Path]",
				copilot = "[Copilot]",
			},
			symbol_map = {
				Copilot = "",
			},
		}),
	},

	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	}),

	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_active_entry() then
					cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
			c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
		}),

		-- Tab/Shift-Tab for snippet expansion and jumping
		["<Tab>"] = cmp.mapping(function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end, { "i", "s" }),
	}),

	experimental = {
		ghost_text = true,
	},
})
