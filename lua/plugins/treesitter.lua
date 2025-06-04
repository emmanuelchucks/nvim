-- treesitter.lua
--

return {
	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"css",
					"diff",
					"html",
					"http",
					"hurl",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"regex",
					"rust",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})

			-- Support dotenv files
			vim.filetype.add({ extension = { vars = "sh" } })
			vim.filetype.add({ pattern = { [".env.*"] = "sh" } })
		end,
	},
}
