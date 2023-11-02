-- Enable relative line numbers
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim
vim.o.clipboard = "unnamedplus"

-- Set highlight on search
vim.o.hlsearch = false

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Confirm save before exit
vim.o.confirm = true

return {}