return {

    -- Mason (installer)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Auto-install LSPs
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "ast_grep",
                    "html",
                },

                -- You can keep custom handlers for very special cases,
                -- but most can now be removed / simplified
            })
        end,
    },

    -- lspconfig (provides default configs + we override here)
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },  -- if you're using cmp
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Modern way: define configs + enable

            -- Example: your special html config
            vim.lsp.config("html", {
                capabilities = capabilities,
                filetypes = { "html" },
                init_options = {
                    provideFormatter = true,
                    configuration = {
                        html = { autoClosingTags = true },
                    },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                },
            })

            -- ts_ls example
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "astro",
                },
                init_options = {
                    preferences = {
                        includeCompletionsForModuleExports = true,
                    },
                },
            })

            -- neocmake ← here is what you want
            vim.lsp.config("neocmake", {
                capabilities = capabilities,
                init_options = { command_case = "lower_case", use_snippets = false },
            })

            -- Optional: fallback for all other servers that have default config
            -- (mason-lspconfig already installed them → they'll get auto-enabled with defaults)
            -- You normally don't need to do anything for them anymore

            -- Your global LSP settings & keymaps
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

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })
        end,
    },
}
