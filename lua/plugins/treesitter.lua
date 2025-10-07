return {
	"nvim-treesitter/nvim-treesitter",
	build = ":tsupdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			highlight = {
                enable = true,
                disable = { "sh", "bash", },
            },
			indent = { enable = true },
            fold = {enable = true},
		})
	end,
}
