return {
	-- nvim-autopairs plugin
    {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true, -- Enables Treesitter-based pairing for certain filetypes
			})
		end,
	},
}
