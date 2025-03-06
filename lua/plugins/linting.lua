-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
	config = function()
		require("lint").linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			css = { "eslint_d" },
		}
	end,
}
