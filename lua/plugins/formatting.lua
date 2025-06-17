-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			css = { "prettierd" },
			markdown = { "prettierd" },
			html = { "prettierd" },
			mdx = { "prettierd" },
			yaml = { "prettierd" },
			lua = { "stylua" },
		},
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
