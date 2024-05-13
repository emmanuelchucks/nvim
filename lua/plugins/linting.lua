-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
	config = function(opts)
		vim.api.nvim_create_autocmd(opts.event, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
