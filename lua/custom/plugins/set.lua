-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Auto save on focus lost
vim.api.nvim_create_autocmd('FocusLost', {
	group = vim.api.nvim_create_augroup 'AutoSaveAutogroup',
	callback = function()
		vim.api.nvim_cmd({ cmd = 'FormatWrite' }, {})
	end,
})

return {}
