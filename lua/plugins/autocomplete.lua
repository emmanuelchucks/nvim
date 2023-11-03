-- autocomplete.lua
--

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter" },
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",

		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
			mapping = cmp.mapping.preset.insert({
				["<c-space>"] = cmp.mapping.complete(),
				["<cr>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<s-tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
		})
	end,
}