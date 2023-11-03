-- debugger.lua
--

return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre" },
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

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

			automatic_setup = true,
		})

		local prefix = "<leader>d"
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { desc = "Debug: " .. desc })
		end

		-- Basic debugging keymaps
		map(prefix .. "c", dap.continue, "Start/Continue")
		map(prefix .. "i", dap.step_into, "Step Into")
		map(prefix .. "o", dap.step_over, "Step Over")
		map(prefix .. "u", dap.step_out, "Step Out")
		map(prefix .. "b", dap.toggle_breakpoint, "Toggle Breakpoint")
		map(prefix .. "B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Set Breakpoint")

		require("which-key").register({
			[prefix] = { name = "Debug", _ = "which_key_ignore" },
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

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		map(prefix .. "l", dapui.toggle, "See last session result")

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		dap.adapters = {
			["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter",
					args = { "${port}" },
				},
			},
		}

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "tsx",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end,
}
