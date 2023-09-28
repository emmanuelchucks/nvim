-- formatter.lua
--

return {
	'mhartington/formatter.nvim',
	config = function()
		require('formatter').setup {
			filetype = {
				lua = { require('formatter.filetypes.lua').stylua },
				['*'] = { require('formatter.filetypes.typescript').prettierd },
			},
		}
<<<<<<< HEAD

		-- Auto	format on save
		vim.api.nvim_create_autocmd('BufWritePost', {
			group = vim.api.nvim_create_augroup('FormatOnSaveAutoGroup', { clear = true }),
			callback = function()
				-- if file is not empty
				if vim.fn.getline(1) ~= '' then
					vim.cmd 'FormatWrite'
				end
			end,
		})
=======
>>>>>>> 37fccc6 (update with more custom plugins)
	end,
}
