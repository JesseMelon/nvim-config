return {
    { -- LSP management
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    { -- Ensuring LSPs are installed
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-8" } -- Force UTF-8 encoding

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ast_grep",
                    "html",
                    "emmet_ls",
                    "ts_ls",
                    "bashls",
                },
                handlers = {
                    -- Custom setup for clangd
                    ["clangd"] = function()
                        local lspconfig = require("lspconfig") -- Scoped require to avoid global warning
                        lspconfig.clangd.setup({
                            capabilities = capabilities,
                            cmd = { "clangd", "--header-insertion=never" },
                            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                            root_dir = lspconfig.util.root_pattern(
                                ".clangd",
                                ".clang-tidy",
                                ".clang-format",
                                "compile_commands.json",
                                "compile_flags.txt",
                                "configure.ac",
                                ".git"
                            ),
                        })
                    end,
                    -- Custom setup for html
                    ["html"] = function()
                        local lspconfig = require("lspconfig") -- Scoped require
                        lspconfig.html.setup({
                            capabilities = capabilities,
                            filetypes = { "html" },
                            init_options = {
                                provideFormatter = true,
                                configuration = {
                                    html = {
                                        autoClosingTags = true,
                                    },
                                },
                            },
                        })
                    end,
                    -- Custom setup for emmet_ls
                    ["emmet_ls"] = function()
                        local lspconfig = require("lspconfig") -- Scoped require
                        lspconfig.emmet_ls.setup({
                            capabilities = capabilities,
                            filetypes = { "html", "css" },
                            init_options = {
                                html = {
                                    options = {
                                        ["bem.enabled"] = true,
                                    },
                                },
                            },
                        })
                    end,
                    -- Default handler for other servers (with capabilities)
                    function(server_name)
                        local lspconfig = require("lspconfig") -- Scoped require
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
            })
        end,
    },
    { -- LSP integration (global settings only)
        "neovim/nvim-lspconfig",
        config = function()
            -- Enable inline diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        return string.format("%s", diagnostic.message)
                    end,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = false,
            })

            -- Keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
