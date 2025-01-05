-- coding.lua
--

return {
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
		"stevearc/oil.nvim",
		opts = {},
	},

	{
		"davidmh/mdx.nvim",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
	},

	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			log_level = "off",
			ignore_filetypes = {
				"gitcommit",
				"gitrebase",
				"markdown",
				"help",
				"text",
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

	{
		"jellydn/hurl.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
		ft = "hurl",
		config = function()
			require("hurl").setup({
				auto_close = false,
				formatters = {
					html = { "tidy", "-i", "-q", "--tidy-mark", "no" },
				},
			})

			local wk = require("which-key")

			wk.add({
				{ "<leader>r", group = "Run" },
				{ "<leader>rr", "<cmd>HurlRunnerAt<cr>", desc = "Run API request" },
				{ "<leader>rR", "<cmd>HurlRunner<cr>", desc = "Run all API requests" },
				{ "<leader>rv", "<cmd>HurlVerbose<cr>", desc = "Run API request (verbose mode)" },
			})
		end,
	},
}
