-- mini.lua
--

return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.statusline").setup()
		require("mini.bracketed").setup()
		require("mini.move").setup()
		require("mini.sessions").setup()
		require("mini.starter").setup()
		require("mini.surround").setup()
		require("mini.operators").setup()
		require("mini.pairs").setup()
		require("mini.files").setup()
		require("mini.misc").setup_restore_cursor()

		local spec_treesitter = require("mini.ai").gen_spec.treesitter

		require("mini.ai").setup({
			n_lines = 500,
			custom_textobjects = {
				f = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
				o = spec_treesitter({
					a = { "@conditional.outer", "@loop.outer" },
					i = { "@conditional.inner", "@loop.inner" },
				}),
			},
		})

		local toggle_key = "t"

		require("mini.basics").setup({
			mappings = {
				move_with_alt = true,
				option_toggle_prefix = toggle_key,
			},
		})

		local wk = require("which-key")

		wk.add({
			{ toggle_key, group = "Toggle" },
		})

		wk.add({
			{ "<leader>s", group = "Sessions" },
			{ "<leader>sr", "<cmd>lua MiniSessions.select('read')<cr>", desc = "Read session" },
			{ "<leader>sd", "<cmd>lua MiniSessions.select('delete')<cr>", desc = "Delete session" },
			{
				"<leader>sw",
				"<cmd>lua MiniSessions.write(vim.fn.input('Session name: '))<cr>",
				desc = "Write session",
			},
		})
	end,
}
