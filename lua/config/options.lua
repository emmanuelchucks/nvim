-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Set highlight on search
vim.o.hlsearch = false

-- Confirm save before exit
vim.o.confirm = true

-- Increase scroll offset
vim.o.scrolloff = 8

-- Reduce default tab stop
vim.o.tabstop = 2

-- Tailwind CSS
vim.o.wrap = true

return {}
