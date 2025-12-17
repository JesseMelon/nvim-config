vim.keymap.set("i", "<CR>", function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	local pairs = { ["("] = ")", ["["] = "]", ["{"] = "}" }
	local char = line:sub(col, col)
	local next_char = line:sub(col + 1, col + 1)

	if pairs[char] and next_char == pairs[char] then
		return "<CR><CR><Up><Tab>"
	else
		return "<CR>"
	end
end, { expr = true, noremap = true })

vim.keymap.set('n', '#', 'i#', { noremap = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
