-- autocomplete.lua
--

return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"Kaiser-Yang/blink-cmp-git",
		"mikavilpas/blink-ripgrep.nvim",
		"rafamadriz/friendly-snippets",
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
	},
	-- use a release tag to download pre-built binaries
	version = "1.*",
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
		sources = {
			default = {
				"avante",
				"lsp",
				"path",
				"snippets",
				"buffer",
				"ripgrep",
				"git",
			},
			per_filetype = {
				sql = {
					"snippets",
					"dadbod",
					"buffer",
				},
			},
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {
						-- options for blink-cmp-avante
					},
				},
				dadbod = {
					module = "vim_dadbod_completion.blink",
					name = "Dadbod",
				},
				git = {
					module = "blink-cmp-git",
					name = "Git",
					opts = {
						-- options for the blink-cmp-git
					},
				},
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
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
