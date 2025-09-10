return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.astyle.with({
					args = function(params)
						return {
							"--style=linux",           -- Use Linux kernel style
							"--indent=tab=8",          -- 8-space tabs
							"--align-pointer=type",    -- Pointers aligned with type
							"--align-reference=type",  -- References aligned with type
							"--pad-oper",              -- Pad operators with spaces
							"--unpad-paren",           -- Remove extra spaces inside parens
							"--pad-header",            -- Add space after if/while/for
							"--keep-one-line-blocks",  -- Preserve one-line blocks
							"--keep-one-line-statements", -- Preserve one-line statements
							"--convert-tabs",          -- Convert tabs to spaces where needed
							"--max-code-length=80",    -- Enforce 80-column limit
							"--break-after-logical",   -- Break after logical operators
						}
					end,
				}),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
