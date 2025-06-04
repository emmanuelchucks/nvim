-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			css = { "prettier" },
			markdown = { "prettier" },
			html = { "prettier" },
			mdx = { "prettier" },
			yaml = { "prettier" },
			lua = { "stylua" },
		},
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	},
}
