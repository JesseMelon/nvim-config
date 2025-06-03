return {
	{	--lsp management
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{	--ensuring lsp's installed
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
					"ast_grep",
				}
			})
		end
	},
	{	--lsp integration
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Enable inline diagnostics with virtual text for all LSP sources (including none-ls)
      		vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						return string.format("%s", diagnostic.message)
					end,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = false,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
                cmd = { "clangd", "--header-insertion=never" },
            })
			lspconfig.ast_grep.setup({
				capabilities = capabilities
			})
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
			vim.keymap.set({'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,{})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
		end
	}
}
