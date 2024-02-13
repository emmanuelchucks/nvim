-- treesitter.lua
--

return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
	config = function()
		vim.defer_fn(function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"css",
					"html",
					"http",
					"json",
					"jsonc",
					"lua",
					"markdown",
					"rust",
					"toml",
					"tsx",
					"typescript",
					"yaml",
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

		-- Support mdx files
		vim.filetype.add({ extension = { mdx = "markdown.mdx" } })
	end,
}
