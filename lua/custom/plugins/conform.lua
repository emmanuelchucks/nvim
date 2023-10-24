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

		-- Automatically run slow formatters async
		local slow_format_filetypes = {}
		require('conform').setup {
			format_on_save = function(bufnr)
				if slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				local function on_format(err)
					if err and err:match 'timeout$' then
						slow_format_filetypes[vim.bo[bufnr].filetype] = true
					end
				end

				return { timeout_ms = 200, lsp_fallback = true }, on_format
			end,

			format_after_save = function(bufnr)
				if not slow_format_filetypes[vim.bo[bufnr].filetype] then
					return
				end
				return { lsp_fallback = true }
			end,
		}
	end,
}
