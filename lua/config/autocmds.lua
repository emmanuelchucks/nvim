-- autocmds.lua
--

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end

		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Hide line numbers when in a terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("hide_numbers"),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

return {}
