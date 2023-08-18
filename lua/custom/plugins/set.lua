-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Switch buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })

-- Auto	format on save
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufWritePost' }, {
	group = vim.api.nvim_create_augroup('FormatOnSaveAutoGroup', { clear = true }),
	callback = function()
		-- if file is not empty
		if vim.fn.getline(1) ~= '' then
			vim.cmd 'FormatWrite'
		end
	end,
})

return {}