-- formatting.lua
--

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			javascript = { "biome-check" },
			javascriptreact = { "biome-check" },
			typescript = { "biome-check" },
			typescriptreact = { "biome-check" },
			json = { "biome-check" },
			jsonc = { "biome-check" },
			lua = { "stylua" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
}
