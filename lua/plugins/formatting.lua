-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "eslint_d", "prettierd" },
			javascriptreact = { "eslint_d", "prettierd" },
			typescript = { "eslint_d", "prettierd" },
			typescriptreact = { "eslint_d", "prettierd" },
			json = { "eslint_d", "prettierd" },
			jsonc = { "eslint_d", "prettierd" },
			css = { "eslint_d", "prettierd" },
			markdown = { "eslint_d", "prettierd" },
			html = { "eslint_d", "prettierd" },
			mdx = { "eslint_d", "prettierd" },
			yaml = { "eslint_d", "prettierd" },
			lua = { "stylua" },
		},
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
