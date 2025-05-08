-- keymaps.lua
--

return {
	"folke/which-key.nvim",
	event = { "VeryLazy" },
	config = function()
		local wk = require("which-key")
		local extras = require("which-key.extras")

		wk.setup({
			spec = {
				{ "<space>", "<nop>", mode = { "n", "v" } },
				{ "<leader>w", proxy = "<c-w>", group = "Windows" },
				{ "<leader>b", expand = extras.expand.buf, group = "Buffers" },
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
