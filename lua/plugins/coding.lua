-- coding.lua
--

return {
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.statusline").setup()
			require("mini.bracketed").setup()
			require("mini.move").setup()
			require("mini.sessions").setup()
			require("mini.starter").setup()
			require("mini.surround").setup()
			require("mini.misc").setup_restore_cursor()

			local spec_treesitter = require("mini.ai").gen_spec.treesitter

			require("mini.ai").setup({
				n_lines = 500,
				custom_textobjects = {
					f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
					o = spec_treesitter({
						a = { "@conditional.outer", "@loop.outer" },
						i = { "@conditional.inner", "@loop.inner" },
					}),
				},
			})

			local toggle_key = "t"

			require("mini.basics").setup({
				mappings = {
					move_with_alt = true,
					option_toggle_prefix = toggle_key,
				},
			})

			require("which-key").add({
				{ toggle_key, group = "Toggle" },
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

			require("which-key").add({
				{ "<leader>f", group = "Find" },
				{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
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
