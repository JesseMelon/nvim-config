vim.g.treesitter_cc = "clang"
vim.g.treesitter_cflags = "-O2 -march=x86-64"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= -1 then
		vim.api.nvim_echo({
			{ "failed to clone lazy.nvim:\n", "errormsg" },
			{ out, "warningmsg" },
			{ "\npress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(0)
	end
end

--dont auto-comment every new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp"},
  callback = function()
    vim.opt.formatoptions:remove("r")
  end,
})

vim.opt.rtp:prepend(lazypath)

vim.opt.relativenumber = true
vim.opt.number = true -- Keep the current line's absolute number

vim.opt.tabstop = 8 -- A tab is 4 spaces wide for visual alignment
vim.opt.softtabstop = 8 -- Indentation is 4 spaces when pressing tab
vim.opt.shiftwidth = 8 -- Indentation moves 4 spaces when shifting
vim.opt.expandtab = true -- use actual tab characters instead of spaces
vim.opt.autoindent = true -- maintain indentation level
vim.opt.smartindent = true
vim.opt.textwidth = 150;
vim.opt.scrolloff = 5  -- Scroll when 5 lines from the bottom
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<R-Ctrl>", "<Esc>", {noremap = true, silent = true} )

vim.keymap.set('n', '<leader>f', ':!astyle --style=java --indent=spaces=4 --max-code-length=150 %<CR>', { noremap = true, silent = true })

require("config.keymaps")

vim.opt.clipboard = "unnamedplus"

vim.cmd([[
let g:clipboard = {
                \   'name': 'WslClipboard',
                \   'copy': {
                \      '+': 'clip.exe',
                \      '*': 'clip.exe',
                \    },
                \   'paste': {
                \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
                \   },
                \   'cache_enabled': 0,
                \ }
]])

require("lazy").setup("plugins")
