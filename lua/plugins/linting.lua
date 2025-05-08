-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
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
			callback = function()
				local eslint_config_exists = vim.fn.glob(vim.fn.getcwd() .. "/eslint.config.*")

				if eslint_config_exists ~= "" then
					vim.cmd("LspEslintFixAll")
				end
			end,
		})
	end,
}
