return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- The setup function is now located directly on the main module
        require("nvim-treesitter").setup({
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "sh", "bash" },
            },
            indent = {
                enable = true,
                disable = { "cmake", "html" },
            },
            -- Note: Treesitter folding is typically handled by Neovim options,
            -- but keeping this here for your preference.
            fold = { enable = true },
        })
    end,
}

