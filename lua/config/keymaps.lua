-- keymaps.lua
--

return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = { "VeryLazy" },
	config = function()
		local wk = require("which-key")

		wk.setup({
			icons = {
				mappings = false,
			},
			spec = {
				{ "<space>", "<nop>", mode = { "n", "v" } },
				{ "<leader>e", vim.diagnostic.open_float, desc = "Open floating diagnostic message" },
			},
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "s", mode = { "n", "v" } },
				{ "t", mode = { "n", "v" } },
			},
		})
	end,
}
