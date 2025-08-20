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
			json = { "eslint" },
			jsonc = { "eslint" },
			markdown = { "eslint" },
			html = { "eslint" },
			css = { "eslint" },
			mdx = { "eslint" },
			yaml = { "eslint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("fix-on-save", { clear = true }),
			callback = function()
				local clients = vim.lsp.get_clients({ bufnr = 0, name = "eslint" })
				if #clients > 0 then
					vim.cmd("LspEslintFixAll")
				end
			end,
		})
	end,
}
