-- none.lua
--

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local none_ls = require("null-ls")

		none_ls.setup({
			sources = {
				none_ls.builtins.diagnostics.eslint_d.with({
					extra_filetypes = { "astro" },
				}),
				none_ls.builtins.formatting.eslint_d.with({
					extra_filetypes = { "astro" },
				}),
				none_ls.builtins.formatting.prettierd.with({
					extra_filetypes = { "astro" },
				}),
				none_ls.builtins.formatting.stylua,
			},

			on_attach = function(client, bufnr)
				-- Format on save
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup("lsp_format_on_save"),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,
		})
	end,
}
