return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.astyle.with({
					args = function(params)
						print(vim.inspect(params))
						return {
							"--style=linux",
							"--indent=tab=8", -- Linux kernel uses 8-space tabs
							"--align-pointer=type", -- Pointer alignment to type
							"--pad-oper", -- Pad operators with spaces
							"--unpad-paren", -- Remove extra padding around parentheses
							"--keep-one-line-statements", -- Preserve one-line statements
							"--keep-one-line-blocks", -- Preserve one-line blocks
							"--convert-tabs", -- Convert tabs to spaces where needed
							"--max-code-length=80", -- Enforce 80-column limit
							"--mode=c", -- Explicitly set C/C++ mode

						}
					end,
				}),
                null_ls.builtins.formatting.cmake_format,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
