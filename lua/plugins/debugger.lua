-- debugger.lua
--

return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Shows virtual text for the current line's breakpoints
		{ "theHamsta/nvim-dap-virtual-text", opts = {} },

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local wk = require("which-key")

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
					runtimeExecutable = "node",
					runtimeArgs = { "--experimental-strip-types" },
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

		wk.add({
			{ "<leader>d", group = "Debug" },
			{ "<leader>ds", dap.continue, desc = "Start/Continue" },
			{ "<leader>di", dap.step_into, desc = "Step into" },
			{ "<leader>do", dap.step_over, desc = "Step over" },
			{ "<leader>dO", dap.step_out, desc = "Step out" },
			{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
			{ "<leader>dB", dap.set_breakpoint, desc = "Set breakpoint" },
			{ "<leader>dl", dap.run_last, desc = "Run last" },
			{ "<leader>dL", dapui.toggle, desc = "See last session result" },
			{ "<leader>dq", dap.disconnect, desc = "Disconnect" },
		})
	end,
}
