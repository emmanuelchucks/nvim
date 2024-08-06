-- treesitter.lua
--

return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile", "BufWritePre" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"css",
				"html",
				"http",
				"json",
				"jsonc",
				"lua",
				"markdown",
				"toml",
				"tsx",
				"typescript",
				"yaml",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- Support mdx files
		vim.filetype.add({ extension = { mdx = "markdown.mdx" } })
	end,
}
