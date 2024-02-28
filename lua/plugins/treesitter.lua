-- treesitter.lua
--

return {
	-- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
				"rust",
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
