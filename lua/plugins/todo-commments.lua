return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>st", "<cmd>TodoTelescope<cr>",       desc = "Todo (Telescope)" },
        { "<leader>td", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
}
