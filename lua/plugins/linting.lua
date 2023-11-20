-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
	config = function(opts)
		require("lint").linters_by_ft = {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			astro = { "eslint_d" },
		}

		vim.api.nvim_create_autocmd(opts.event, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				-- Only run if config file exists
				if vim.fn.glob(vim.fn.getcwd() .. "/.eslintrc*") ~= "" then
					require("lint").try_lint()
				end
			end,
		})
	end,
}
