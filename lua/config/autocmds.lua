-- autocmds.lua
--

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto-create-dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end

		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

return {}
