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
				[toggle_key] = { name = "Toggle", _ = "which_key_ignore" },
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
		event = { "InsertEnter" },
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
			suggestion = {
				auto_trigger = true,
			},
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "VeryLazy" },
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