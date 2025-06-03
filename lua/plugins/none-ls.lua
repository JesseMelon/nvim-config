return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.astyle.with({
					args = function(params)
						print(vim.inspect(params))
						return {
							"--style=java",
							"--indent=spaces=4",
						}
					end,
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
