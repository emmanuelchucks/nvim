-- telescope.lua
--

local builtin = require("telescope.builtin")

local prefix = "<leader>f"
require("which-key").register({
	[prefix] = { name = "Find", _ = "which_key_ignore" },
})

return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{ "<leader><space>", builtin.git_files, desc = "Find git files" },
		{ prefix .. "/", builtin.current_buffer_fuzzy_find, desc = "Find in current buffer" },
		{ prefix .. "o", builtin.oldfiles, desc = "Find recent files" },
		{ prefix .. "f", builtin.find_files, desc = "Find files" },
		{ prefix .. "g", builtin.live_grep, desc = "Find by grep" },
		{ prefix .. "b", builtin.buffers, desc = "Find buffers" },
		{ prefix .. "d", builtin.diagnostics, desc = "Find diagnostics" },
		{ prefix .. "h", builtin.help_tags, desc = "Find help" },
		{ prefix .. "r", builtin.resume, desc = "Find resume" },
		{ prefix .. "w", builtin.grep_string, desc = "Find word by grep" },
		{ prefix .. "s", builtin.spell_suggest, desc = "Find spelling" },
		{ prefix .. "k", builtin.keymaps, desc = "Find keymaps" },
	},
}
