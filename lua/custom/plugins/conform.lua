-- conform.lua
--

return {
	'stevearc/conform.nvim',
	config = function()
		require('conform').setup {
			formatters_by_ft = {
				javascript = { 'eslint_d', 'prettierd' },
				javascriptreact = { 'eslint_d', 'prettierd' },
				typescript = { 'eslint_d', 'prettierd' },
				typescriptreact = { 'eslint_d', 'prettierd' },
				astro = { 'eslint_d', 'prettierd' },
				json = { 'prettierd' },
				jsonc = { 'prettierd' },
				markdown = { 'prettierd' },
				lua = { 'stylua' },
			},

			formatters = {
				eslint_d = {
					condition = function(ctx)
						-- only if there is an eslint config file (e.g. .eslintrc)
						local possible_configs = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', '.eslintrc.yml' }
						local config = require('conform.util').root_file(possible_configs)(ctx)
						return config ~= nil
					end,
				},
			},
		}

		-- Auto	format on save
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('FormatOnSaveAutoGroup', { clear = true }),
			callback = function()
				--   if buffer is not empty
				if vim.fn.getline(1) ~= '' then
					require('conform').format()
				end
			end,
		})
	end,
}
