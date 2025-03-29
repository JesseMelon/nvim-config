return {
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			require("luasnip.loaders.from_vscode").lazy_load()

			local first_opt = true --for cycling predictions from second, since first is default

			cmp.setup({
				completion = {
					keyword_length = 1,
				},
				experimental = {
					ghost_text = true,
				},
				snippet = {
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) --for 'vsnip'
						require("luasnip").lsp_expand(args.body) --for luasnip
						-- require('snippy').expand_snippet(args.body) --for snippy
						-- vim.fn["UltiSnips#Anon"](args.body) --for ultisnips
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						max_height = 5, -- limit the height of the completion window to 5 lines
						max_width = 50, -- (optional) limit the width
					}),
					documentation = cmp.config.window.bordered({
						max_height = 10, -- limit the height of the documentation window
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping(function(fallback)
						if require("luasnip").jumpable(1) then
							require("luasnip").jump(1)
						else
							local col = vim.api.nvim_win_get_cursor(0)[2] -- Get current column (0-based)
							local line = vim.api.nvim_get_current_line() -- Get current line text
							local closures =
								{ [")"] = true, ["]"] = true, ["}"] = true, ["'"] = true, ['"'] = true, [">"] = true }
							local moved = false

							-- hop out of closures
							while col < #line and closures[line:sub(col + 1, col + 1)] do
								vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], col + 1 })
								col = col + 1
								moved = true
							end
							if moved == false then
								fallback()
							end
						end
					end, { "i", "s" }),

					["<C-j>"] = cmp.mapping(function(fallback)
						if require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Esc>"] = cmp.mapping(function(fallback)
						first_opt = true
						fallback()
					end),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							first_opt = true
							cmp.confirm({ select = true }) -- Confirm selection
						else
							fallback() -- Insert a normal tab if no completion is available
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							first_opt = true
							cmp.confirm({ select = true }) -- Confirm selection
						else
							fallback() -- Insert a normal tab if no completion is available
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							if first_opt then
								cmp.select_next_item() -- Skip first item on first press
								cmp.select_next_item()
								first_opt = false
							else
								cmp.select_next_item()
							end
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					-- { name = "vsnip" },
					-- { name = "luasnip" }, --luasnip, ultisnips, snippy
				}, {
					{ name = "buffer", keyword_length = 3 },
				}),
			})
		end,
	},
}
