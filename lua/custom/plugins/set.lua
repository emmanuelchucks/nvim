-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Auto	format on save
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufWritePost' }, {
	group = vim.api.nvim_create_augroup('FormatOnSaveAutoGroup', {}),
	callback = function()
		vim.api.nvim_cmd({ cmd = 'FormatWrite' }, {})
	end,
})

return {}
