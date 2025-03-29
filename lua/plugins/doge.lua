return {
    {
    "kkoomen/vim-doge",
    build = ":call doge#install()", -- Runs post-install to set up binaries/docs
    config = function()
    -- Optional basic setup
    vim.g.doge_mapping = "<Leader>d" -- Default keybinding
  end,
    }
}
