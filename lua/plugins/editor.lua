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
			require("onedark").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("onedark")
		end,
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
		config = function()
			require("rest-nvim").setup({
				result_split_horizontal = true,
				result_split_in_place = true,
			})

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
