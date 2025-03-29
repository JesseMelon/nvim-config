return {
	"nvim-lualine/lualine.nvim",
	priority = 0,
	config = function()
		require("lualine").setup({
		  	options = {
		    		theme = 'auto'
			}
		})
	end
}
