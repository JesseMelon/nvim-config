return {
  "simrat39/symbols-outline.nvim",
  config = function()
    require("symbols-outline").setup()
    vim.keymap.set("n", "<leader>o", ":SymbolsOutline<CR>", { noremap = true, silent = true })
  end,
}
