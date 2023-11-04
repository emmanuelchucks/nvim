-- keymaps.lua
--

return {
	-- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = { "VeryLazy" },
	opts = {},
	config = function()
		local wk = require("which-key")
		wk.register({
			["<leader>"] = {
				e = { vim.diagnostic.open_float, "Open floating diagnostic message" },
				l = { "<cmd>Lazy<cr>", "Open lazy" },
				m = { "<cmd>Mason<cr>", "Open mason" },
			},
		})

		wk.register({
			["<space>"] = { "<nop>" },
		}, { mode = { "n", "v" }, silent = true })
	end,
}
