-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
	config = function()
		require("lint").linters_by_ft = {
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			css = { "eslint" },
		}

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("eslint-fix-on-save", { clear = true }),
			pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
			command = "EslintFixAll",
		})
	end,
}
