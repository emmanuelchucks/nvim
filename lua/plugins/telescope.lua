-- telescope.lua
--

local prefix = "<leader>f"
require("which-key").register({
	[prefix] = { name = "Find", _ = "which_key_ignore" },
})

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	cmd = { "Telescope" },
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
	keys = {
		{ "<leader><space>", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
		{ prefix .. "/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer" },
		{ prefix .. "o", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
		{ prefix .. "f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ prefix .. "g", "<cmd>Telescope live_grep<cr>", desc = "Find by grep" },
		{ prefix .. "b", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
		{ prefix .. "d", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },
		{ prefix .. "h", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
		{ prefix .. "r", "<cmd>Telescope resume<cr>", desc = "Find resume" },
		{ prefix .. "w", "<cmd>Telescope grep_string<cr>", desc = "Find word by grep" },
		{ prefix .. "s", "<cmd>Telescope spell_suggest<cr>", desc = "Find spelling" },
		{ prefix .. "k", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
	},
}
