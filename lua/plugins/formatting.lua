-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			javascript = { "eslint_d", "prettierd" },
			javascriptreact = { "eslint_d", "prettierd" },
			typescript = { "eslint_d", "prettierd" },
			typescriptreact = { "eslint_d", "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			markdown = { "prettierd" },
			lua = { "stylua" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},

		formatters = {
			eslint_d = {
				condition = function()
					return vim.fn.glob(vim.fn.getcwd() .. "/.eslintrc*") ~= ""
				end,
			},
		},
	},
}
