-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
<<<<<<< HEAD
vim.opt.autowrite = true

-- Switch buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Go to next buffer' })
=======
vim.opt.autowriteall = true

-- Run formatter on save
vim.cmd [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]]
>>>>>>> 37fccc6 (update with more custom plugins)

return {}
