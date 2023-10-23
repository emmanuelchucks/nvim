-- lint.lua
--

return {
	'mfussenegger/nvim-lint',
	config = function()
		require('lint').linters_by_ft = {
			javascript = { 'eslint_d' },
			javascriptreact = { 'eslint_d' },
			typescript = { 'eslint_d' },
			typescriptreact = { 'eslint_d' },
			astro = { 'eslint_d' },
		}

		-- Lint on save
		vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
			group = vim.api.nvim_create_augroup('LintOnSaveAutoGroup', { clear = true }),
			callback = function()
					require('lint').try_lint()
			end,
		})
	end,
}
