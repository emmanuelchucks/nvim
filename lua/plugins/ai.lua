-- ai.lua
--

return {
	{
		"supermaven-inc/supermaven-nvim",
		opts = {
			log_level = "off",
			ignore_filetypes = {
				"markdown",
				"help",
				"text",
			},
		},
	},

	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			-- Recommended for `ask()`, required for `toggle()` — otherwise optional
			{ "folke/snacks.nvim", opts = { input = { enabled = true } } },
		},
		config = function()
			---@type opencode.Opts
			vim.g.opencode_opts = {
				-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
			}

			-- Required for `opts.auto_reload`.
			vim.o.autoread = true

			-- Recommended/example keymaps.
			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ", { submit = true })
			end, { desc = "Ask opencode" })
			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Execute opencode action…" })
			vim.keymap.set({ "n", "x" }, "ga", function()
				require("opencode").prompt("@this")
			end, { desc = "Add to opencode" })
			vim.keymap.set({ "n", "t" }, "<C-.>", function()
				require("opencode").toggle()
			end, { desc = "Toggle opencode" })
			vim.keymap.set("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "opencode half page up" })
			vim.keymap.set("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "opencode half page down" })
			-- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
			vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
			vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
		end,
	},
}
