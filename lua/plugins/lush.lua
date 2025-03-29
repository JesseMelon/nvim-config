return {
	{
		"rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("lush")(require("custom_theme"))
			-- Ensure DAP UI reloads after the color scheme is set
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					require("dapui").setup()
				end,
			})
		end,
	},
}
