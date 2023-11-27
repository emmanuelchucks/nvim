-- debugger.lua
--

return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Shows virtual text for the current line's breakpoints
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			ensure_installed = {
				"js",
			},

			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_setup = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			}
		end

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch (Node)",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "bunx",
					runtimeArgs = { "tsx" },
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch (Chrome)",
					url = "http://localhost:5173",
					sourceMaps = true,
					webRoot = "${workspaceFolder}",
					protocol = "inspector",
					skipFiles = { "**/node_modules/**/*" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach (Node)",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
					skipFiles = { "${workspaceFolder}/node_modules/**/*" },
				},
			}
		end

		require("which-key").register({
			["<leader>d"] = {
				name = "Debug",
				s = { dap.continue, "Start/Continue" },
				i = { dap.step_into, "Step into" },
				o = { dap.step_over, "Step over" },
				u = { dap.step_out, "Step out" },
				b = { dap.toggle_breakpoint, "Toggle breakpoint" },
				B = { dap.set_breakpoint, "Set breakpoint" },
				l = { dapui.toggle, "See last session result" },
			},
		})
	end,
}
