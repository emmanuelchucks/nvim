-- treesitter.lua
--

return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufEnter" },
	config = function()
		vim.defer_fn(function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "http", "json", "jsonc", "lua", "vim", "vimdoc", "query" },
				auto_install = true,
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
