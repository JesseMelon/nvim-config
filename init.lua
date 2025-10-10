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
    vim.opt.tabstop = 8
    vim.opt.softtabstop = 8
    vim.opt.shiftwidth = 8
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"lua", "sh", "dosbatch", "cmake", "html"},
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"xml"},
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.expandtab = true
  end,
})

vim.opt.rtp:prepend(lazypath)

vim.opt.relativenumber = true
vim.opt.number = true -- Keep the current line's absolute number
vim.opt.formatoptions:remove("r", "o")
vim.opt.autoindent = true -- maintain indentation level
vim.opt.smartindent = true
vim.opt.textwidth = 150;
vim.opt.scrolloff = 5  -- Scroll when 5 lines from the bottom
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<R-Ctrl>", "<Esc>", {noremap = true, silent = true} )

vim.keymap.set('n', '<leader>f', ':!astyle --style=java --indent=spaces=4 --max-code-length=150 %<CR>', { noremap = true, silent = true })

vim.opt.clipboard:append("unnamedplus")

vim.g.clipboard = {
  name = "wl-clipboard",
  copy = {
    ["+"] = "wl-copy",
    ["*"] = "wl-copy",
  },
  paste = {
    ["+"] = "wl-paste",
    ["*"] = "wl-paste",
  },
  cache_enabled = 0, -- Disable caching for simplicity
}

require("config.keymaps")

require("lazy").setup("plugins")
