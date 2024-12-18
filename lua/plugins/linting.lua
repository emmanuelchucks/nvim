-- linting.lua
--

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave", "TextChanged" },
	config = function(opts)
		require("lint").linters_by_ft = {
			javascript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescript = { "biomejs" },
			typescriptreact = { "biomejs" },
			json = { "biomejs" },
			jsonc = { "biomejs" },
			css = { "biomejs" },
		}

		vim.api.nvim_create_autocmd(opts.event, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				if vim.fn.glob(vim.fn.getcwd() .. "/biome*") ~= "" then
					require("lint").try_lint()
				end
			end,
		})
	end,
}
