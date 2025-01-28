-- keymaps.lua
--

local open_terminals = function()
	vim.cmd.vnew()
	vim.cmd.terminal()
	vim.cmd.wincmd("H")
	vim.api.nvim_win_set_width(0, 50)
	vim.cmd.new()
	vim.cmd.terminal()
	vim.cmd.split()
	vim.cmd.terminal()
end

return {
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
				-- Terminal
				{ "<leader>t", open_terminals, desc = "Open terminal" },
				{ "<esc><esc>", "<c-\\><c-n>", desc = "Escape to normal mode", mode = "t", hidden = true },
			},
			triggers = {
				{ "<auto>", mode = "nixsotc" },
				{ "s", mode = { "n", "v" } },
				{ "t", mode = { "n", "v" } },
			},
		})
	end,
}
