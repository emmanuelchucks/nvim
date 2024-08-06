-- coding.lua
--

return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.statusline").setup()
			require("mini.bracketed").setup()
			require("mini.move").setup()
			require("mini.sessions").setup()
			require("mini.starter").setup()
			require("mini.surround").setup()
			require("mini.misc").setup_restore_cursor()

			local toggle_key = "t"

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
		event = { "InsertEnter" },
		opts = {},
	},

	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		opts = {},
	},

	{
		"b0o/schemastore.nvim",
		ft = "json",
	},

	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			log_level = "off",
			ignore_filetypes = {
				gitcommit = true,
				gitrebase = true,
				markdown = true,
				help = true,
				text = true,
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local todo = require("todo-comments")
			todo.setup({ signs = false })
			require("which-key").register({
				["<leader>ft"] = { "<cmd>TodoTelescope<cr>", "Find todos" },
			})
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
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
