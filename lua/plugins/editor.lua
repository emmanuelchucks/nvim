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
		"tpope/vim-sleuth",
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
