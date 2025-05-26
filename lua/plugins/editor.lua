-- editor.lua
--

return {
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({
				transparent = true,
			})

			vim.cmd.colorscheme("onedark")
		end,
	},

	{
		-- Automatically detects which indents should be used in the current buffer
		"tpope/vim-sleuth",
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {},
	},

	{
		-- Add indentation guides even on blank lines
		-- See `:help ibl`
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{
		-- Edit your filesystem like a buffer
		"stevearc/oil.nvim",
		lazy = false,
		opts = {},
	},
}
