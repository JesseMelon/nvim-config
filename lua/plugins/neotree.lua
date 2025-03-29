return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"muniftanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- Show hidden files by default
					hide_dotfiles = false, -- Do NOT hide dotfiles (.* files)
					hide_gitignored = false, -- Do NOT hide gitignored files (optional)
				},
			},
		})

		-- Keymap to toggle Neo-tree
		vim.keymap.set('n', '<c-n>', ':Neotree toggle<CR>', {})
	end,
}

