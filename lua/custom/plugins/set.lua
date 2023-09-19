-- set.lua
--

vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.autowriteall = true

-- Run formatter on save
vim.cmd [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]]

return {}
