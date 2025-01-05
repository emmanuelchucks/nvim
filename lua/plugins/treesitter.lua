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
				"hurl",
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

		-- Support environment variables (.dev.vars)
		vim.filetype.add({ extension = { vars = "sh" } })
	end,
}
