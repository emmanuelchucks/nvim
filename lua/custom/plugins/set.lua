-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Switch buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })

return {}
