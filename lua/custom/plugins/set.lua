-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Run formatter on save
vim.api.nvim_create_autocmd('BufWritePost', {
	group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true }),
	callback = function()
		vim.api.nvim_cmd({ cmd = 'FormatWrite' }, {})
	end,
})

return {}
