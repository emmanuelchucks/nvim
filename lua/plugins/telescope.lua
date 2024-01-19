-- telescope.lua
--

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = { "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available.
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
	config = function()
		local builtin = require("telescope.builtin")

		-- Use telescope for selecting from multiple options
		require("telescope").load_extension("ui-select")

		require("which-key").register({
			["<leader>"] = {
				["<space>"] = { builtin.buffers, "Find buffers" },
				f = {
					name = "Find",
					["/"] = { builtin.live_grep, "Find by grep" },
					["*"] = { builtin.grep_string, "Find word under cursor" },
					d = { builtin.diagnostics, "Find diagnostics" },
					h = { builtin.help_tags, "Find help" },
					r = { builtin.resume, "Find resume" },
					s = { builtin.git_status, "Find git status" },
					j = { builtin.jumplist, "Find jumplist" },
					k = { builtin.keymaps, "Find keymaps" },
					o = { builtin.oldfiles, "Find recent files" },
					q = { builtin.quickfix, "Find quickfix" },
					w = { builtin.lsp_dynamic_workspace_symbols, "Find workspace symbols" },
					f = {
						function()
							if vim.fn.glob(vim.fn.getcwd() .. "/.git") ~= "" then
								builtin.git_files({
									show_untracked = true,
								})
							else
								builtin.find_files()
							end
						end,
						"Find files",
					},
				},
			},
		})
	end,
}
