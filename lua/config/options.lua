-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- Set highlight on search
vim.o.hlsearch = false

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Confirm save before exit
vim.o.confirm = true

-- Increase scroll offset
vim.o.scrolloff = 8

-- Reduce default tab stop
vim.o.tabstop = 2

-- Tailwind CSS
vim.o.wrap = true

return {}
