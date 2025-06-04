-- autocomplete.lua
--

return {
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		"Kaiser-Yang/blink-cmp-git",
		"mikavilpas/blink-ripgrep.nvim",
		"rafamadriz/friendly-snippets",
		"folke/lazydev.nvim",
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = "enter",
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- Shows a signature help window while you type arguments for a function
		signature = {
			enabled = true,
		},

		-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
		-- which automatically downloads a prebuilt binary when enabled.
		--
		-- By default, we use the Lua implementation instead, but you may enable
		-- the rust implementation via `'prefer_rust_with_warning'`
		--
		-- See :h blink-cmp-config-fuzzy for more information
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},

		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
				},
			},
		},

		cmdline = {
			keymap = {
				["<Tab>"] = { "show", "accept" },
			},
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"ripgrep",
				"git",
				"dadbod",
			},

			providers = {
				lazydev = {
					module = "lazydev.integrations.blink",
					name = "Lazydev",
					score_offset = 100,
				},

				dadbod = {
					module = "vim_dadbod_completion.blink",
					name = "Dadbod",
					enabled = function()
						return vim.tbl_contains({ "sql" }, vim.bo.filetype)
					end,
				},

				git = {
					module = "blink-cmp-git",
					name = "Git",
					enabled = function()
						return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
					end,
					opts = {
						-- options for the blink-cmp-git
					},
				},

				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					score_offset = -100,
					-- the options below are optional, some default values are shown
					---@module "blink-ripgrep"
					---@type blink-ripgrep.Options
					opts = {},
				},
			},
		},
	},

	opts_extend = {
		"sources.default",
	},
}
