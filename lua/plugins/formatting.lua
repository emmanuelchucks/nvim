-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd", "eslint_d" },
			javascriptreact = { "prettierd", "eslint_d" },
			typescript = { "prettierd", "eslint_d" },
			typescriptreact = { "prettierd", "eslint_d" },
			json = { "prettierd", "eslint_d" },
			jsonc = { "prettierd", "eslint_d" },
			css = { "prettierd", "eslint_d" },
			markdown = { "prettierd", "eslint_d" },
			html = { "prettierd", "eslint_d" },
			mdx = { "prettierd", "eslint_d" },
			yaml = { "prettierd", "eslint_d" },
			lua = { "stylua" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	},
}
