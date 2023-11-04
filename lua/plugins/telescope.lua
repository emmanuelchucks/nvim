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
			["<leader>f"] = {
				name = "Find",
				["/"] = { builtin.live_grep, "Find by grep" },
				f = { builtin.find_files, "Find files" },
				g = { builtin.git_files, "Find git files" },
				b = { builtin.buffers, "Find buffers" },
				d = { builtin.diagnostics, "Find diagnostics" },
				h = { builtin.help_tags, "Find help" },
				r = { builtin.resume, "Find resume" },
				w = { builtin.grep_string, "Find word by grep" },
				s = { builtin.spell_suggest, "Find spelling" },
				k = { builtin.keymaps, "Find keymaps" },
				o = { builtin.oldfiles, "Find recent files" },
			},
		})
	end,
}
