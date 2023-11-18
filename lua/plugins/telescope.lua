-- telescope.lua
--

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = { "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
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
		require("which-key").register({
			["<leader>"] = {
				name = "Find",
				["<space>"] = { builtin.buffers, "Find buffers" },
				f = {
					["/"] = { builtin.live_grep, "Find by grep" },
					d = { builtin.diagnostics, "Find diagnostics" },
					h = { builtin.help_tags, "Find help" },
					r = { builtin.resume, "Find resume" },
					w = { builtin.grep_string, "Find word by grep" },
					s = { builtin.git_status, "Find git status" },
					k = { builtin.keymaps, "Find keymaps" },
					o = { builtin.oldfiles, "Find recent files" },
					q = { builtin.quickfix, "Find quickfix" },
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
