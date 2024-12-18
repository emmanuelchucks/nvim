-- keymaps.lua
--

return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = { "VeryLazy" },
	config = function()
		local wk = require("which-key")
		local extras = require("which-key.extras")

		wk.setup({
			icons = {
				mappings = false,
			},
			spec = {
				{ "<space>", "<nop>", mode = { "n", "v" } },
				{ "<leader>w", proxy = "<c-w>", group = "Windows" },
				{ "<leader>b", expand = extras.expand.buf, group = "Buffers" },
				{ "<leader>e", vim.diagnostic.open_float, desc = "Open floating diagnostic message" },
				{ "<leader><space>x", "<cmd>source %<cr>", desc = "Reload current file" },
				{ "<leader>x", ":.lua<cr>", desc = "Reload current line" },
				{ "<leader>x", ":lua<cr>", desc = "Reload current line", mode = "v" },
			},
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "s", mode = { "n", "v" } },
				{ "t", mode = { "n", "v" } },
			},
		})
	end,
}
