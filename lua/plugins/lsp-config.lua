return {
    { -- LSP management
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    { -- Ensuring LSPs are installed
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ast_grep",
                    "html",
                    "emmet_ls",
                    "ts_ls",
                    "bashls"
                },
                handlers = {
                    ["clangd"] = function()
                        -- Skip mason-lspconfig's default setup for clangd
                    end,
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = require("cmp_nvim_lsp").default_capabilities(),
                        })
                    end,
                },
            })
        end,
    },
    { -- LSP integration
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            capabilities.offsetEncoding = { "utf-8" } -- Force UTF-8 encoding
            local lspconfig = require("lspconfig")

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

            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd", "--header-insertion=never" },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
                root_dir = require("lspconfig").util.root_pattern(
                    ".clangd",
                    ".clang-tidy",
                    ".clang-format",
                    "compile_commands.json",
                    "compile_flags.txt",
                    "configure.ac",
                    ".git"
                ),
            })
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ts_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ast_grep.setup({
                capabilities = capabilities,
            })
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
