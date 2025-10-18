return {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}
