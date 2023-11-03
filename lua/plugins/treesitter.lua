-- treesitter.lua
--

return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufEnter" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		vim.defer_fn(function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"astro",
					"http",
					"json",
					"jsonc",
					"lua",
					"typescript",
					"tsx",
					"vim",
					"vimdoc",
				},
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
					},
				},
			})
		end, 0)
	end,
}
