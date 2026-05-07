return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
        local lint = require("lint")

        local severities = {
            error   = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            note    = vim.diagnostic.severity.HINT,
        }

        -- Runs only clang-analyzer-* checks as an external process.
        -- bugprone/cert/performance are already handled by clangd in-process.
        lint.linters["clang-analyzer"] = {
            cmd             = "clang-tidy",
            stdin           = false,
            args            = { "--checks=-*,clang-analyzer-*" },
            stream          = "stdout",
            ignore_exitcode = true,
            parser = function(output, _bufnr)
                local diagnostics = {}
                for line in output:gmatch("[^\n]+") do
                    local _file, lnum, col, sev, msg =
                        line:match("^(.+):(%d+):(%d+): (%w+): (.+)$")
                    if lnum and sev ~= "note" then
                        table.insert(diagnostics, {
                            lnum     = tonumber(lnum) - 1,
                            col      = tonumber(col) - 1,
                            message  = msg,
                            severity = severities[sev] or vim.diagnostic.severity.WARN,
                            source   = "clang-tidy",
                        })
                    end
                end
                return diagnostics
            end,
        }

        lint.linters_by_ft = {
            c   = { "clang-analyzer" },
            cpp = { "clang-analyzer" },
        }

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
