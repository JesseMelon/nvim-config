return {
	{
		"mfussenegger/nvim-dap", -- Debug Adapter Protocol (DAP) core
		dependencies = {
			"rcarriga/nvim-dap-ui", -- Debug UI for nvim-dap
			"nvim-neotest/nvim-nio",
            "stevearc/overseer.nvim",
            "theHamsta/nvim-dap-virtual-text",
		},
		after = "rktjmp/lush.nvim",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
            local overseer = require("overseer")

			-- setup adapter
			dap.adapters.codelldb = {
				type = "server",
				port = 12345,
				executable = {
					command = "/home/jessemelon/.local/share/nvim/mason/bin/codelldb",
					args = { "--port", "12345" },
				},
			}

            local function get_executable_path()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end

            local function get_executable_from_vscode_json()
                local launch_json = vim.fn.getcwd() .. "/.vscode/launch.json"
                if vim.fn.filereadable(launch_json) ~= 1 then
                    return nil
                end
                local success, content = pcall(vim.fn.json_decode, vim.fn.readfile(launch_json))
                if not success or type(content) ~= "table" or not content.configurations then
                    return nil
                end
                for _, config in ipairs(content.configurations) do
                    if config.program then
                        return config.program
                    end
                end
                return nil
            end

			-- setup C config
			dap.configurations.c = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					-- preLaunchTask = "Single-Compile",
					program = function()
                        return get_executable_path()
					end,
					cwd = vim.fn.getcwd(),
					stopAtEntry = false,
					runInTerminal = true,
				},
			}

			dap.configurations.cpp = dap.configurations.c -- same configuration for C++

            overseer.register_template({
                name = "Build and Debug",
                builder = function()
                    return {
                        cmd = {"./build.sh"},
                        cwd = vim.fn.getcwd(),
                        components = {
                            {"on_output_parse",
                                parser = require("overseer.parser").new({
                                    diagnostics = {
                                        {"extract", "(%S+):(%d+):(%d):", "filename", "lnum", "col"},
                                    }
                                }),
                            },
                        "default"
                        },
                   }
                end,
                desc = "Build project and set executable",
                on_complete = function(result)
                    if result.success then
                        local executable = get_executable_path()
                        dap.configurations.c[1].program = executable
                    end
                end,
            })

			vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
			vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})
			-- Open DAP UI before attaching or launching
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			-- Key mappings
			vim.keymap.set("n", "<Leader>dc", function()
				require("dap").continue()
			end, { desc = "Continue Debugging" })
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<Leader>ds", function()
				require("dap").step_over()
			end, { desc = "Step Over" })
			vim.keymap.set("n", "<Leader>di", function()
				require("dap").step_into()
			end, { desc = "Step Into" })
			vim.keymap.set("n", "<Leader>du", function()
				require("dap").step_out()
			end, { desc = "Step Out" })
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Open Debug REPL" })
            vim.keymap.set("n", "<Leader>dt", function()
                dap.terminate()
                dapui.close()
            end, { desc = "Terminate Debugging and Close UI" })
			-- Set the color for breakpoints
			vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#FF0000", bg = "#000000", bold = true }) -- Red
			vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#FFFF00", bg = "#000000", bold = true }) -- Yellow
			vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#FFFFFF", bg = "#000000" }) -- Grey for rejected breakpoints

            vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#00FF00", bold = true })

			vim.schedule(function ()
				require("dapui").setup()
                require("nvim-dap-virtual-text").setup({
                    enabled = true,
                    enabled_commands = true,
                    highlight_changed_variables = true,
                    show_stop_reason = true,
                    commented = false,
                    virt_text_pos = "eol",
                })
			end)
		end,
	},
	{
		"rcarriga/nvim-dap-ui", -- DAP UI
		after = "rktjmp/lush.nvim",
	},
	{
		"nvim-neotest/nvim-nio", -- Required dependency for nvim-dap-ui
	},
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup()
		end,
	},
    {
        "theHamsta/nvim-dap-virtual-text",
    }
}
