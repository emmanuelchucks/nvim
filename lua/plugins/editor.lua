-- editor.lua
--

return {
	-- Git related plugins
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		cmd = { "G", "GBrowse" },
	},

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
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				opts = {},
			},

			-- Additional lua configuration, makes nvim stuff amazing!
			{
				"folke/neodev.nvim",
				opts = {},
			},
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		lazy = true,
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	{
		-- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = { "VeryLazy" },
		opts = {},
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		-- See `:help gitsigns.txt`
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
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
		-- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		lazy = true,
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
				config = function()
					-- Enable telescope fzf native, if installed
					pcall(require("telescope").load_extension, "fzf")
				end,
			},
		},
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	{
		"rest-nvim/rest.nvim",
		ft = "http",
		keys = {
			{ "<leader>rr", "<Plug>RestNvim", desc = "Request run" },
			{ "<leader>rp", "<Plug>RestNvimPreview", desc = "Request preview" },
		},
		opts = {
			result_split_in_place = true,
		},
	},
}
