-- editor.lua
--

return {
	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = { "BufReadPre", "BufNewFile" },
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
		-- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = { "VeryLazy" },
		opts = {},
	},

	{
		-- Set lualine as statusline
		-- See `:help lualine.txt`
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
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
		event = { "BufReadPre", "BufNewFile" },
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
			local prefix = "<leader>r"
			local map = function(key, func, desc)
				vim.keymap.set("n", key, func, { desc = desc })
			end

			map(prefix .. "r", "<Plug>RestNvim", "Run request")
			map(prefix .. "p", "<Plug>RestNvimPreview", "Run preview")
			map(prefix .. "l", "<Plug>RestNvimLast", "Run last request")

			require("which-key").register({
				["<leader>r"] = { name = "Rest", _ = "which_key_ignore" },
			})
		end,
	},
}
