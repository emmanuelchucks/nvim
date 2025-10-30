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
		-- Better vim.notify
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
		},
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
