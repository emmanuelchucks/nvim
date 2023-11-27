-- coding.lua
--

return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup()
			require("mini.bracketed").setup()
			require("mini.move").setup()
			require("mini.sessions").setup()
			require("mini.starter").setup()
			require("mini.surround").setup()

			local toggle_key = "<leader>t"
			require("mini.basics").setup({
				mappings = {
					windows = true,
					move_with_alt = true,
					option_toggle_prefix = toggle_key,
				},
			})

			require("which-key").register({
				[toggle_key] = { name = "Toggle" },
			})
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {},
	},

	{
		"b0o/schemastore.nvim",
		ft = "json",
	},

	{
		"zbirenbaum/copilot.lua",
		event = { "InsertEnter" },
		build = ":Copilot auth",
		opts = {
			panel = {
				auto_refresh = true,
				keymap = {
					open = "<m-p>",
				},
			},
			suggestion = {
				auto_trigger = true,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup()
			require("which-key").register({
				["]t"] = { todo.jump_next, "Next todo" },
				["[t"] = { todo.jump_prev, "Previous todo" },
				["<leader>ft"] = { "<cmd>TodoTelescope<cr>", "Find todos" },
			})
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			enable_autocmd = false,
		},
		config = function()
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
					end,
				},
			})
		end,
	},
}
