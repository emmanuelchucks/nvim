-- editor.lua
--

return {
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	},

	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{
		-- Set lualine as statusline
		-- See `:help lualine.txt`
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			options = {
				icons_enabled = false,
				theme = "onedark",
				component_separators = "|",
				section_separators = "",
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		-- See `:help ibl`
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		main = "ibl",
		opts = {},
	},

	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			result_split_in_place = true,
		},
		config = function()
			require("which-key").register({
				["<leader>r"] = {
					name = "Rest",
					r = { "<Plug>RestNvim", "Run request" },
					p = { "<Plug>RestNvimPreview", "Run preview" },
					l = { "<Plug>RestNvimLast", "Run last request" },
				},
			})
		end,
	},
}
