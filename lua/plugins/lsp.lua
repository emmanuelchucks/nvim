-- lsp.lua
--

local servers = {
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
	jsonls = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local builtin = require("telescope.builtin")

	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	-- See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover documentation")

	local code_prefix = "<leader>c"
	map(code_prefix .. "r", vim.lsp.buf.rename, "Rename")
	map(code_prefix .. "a", vim.lsp.buf.code_action, "Code actions")

	local goto_prefix = "<leader>g"
	map(goto_prefix .. "d", builtin.lsp_definitions, "Goto definition")
	map(goto_prefix .. "r", builtin.lsp_references, "Goto references")
	map(goto_prefix .. "i", builtin.lsp_implementations, "Goto implementation")
	map(goto_prefix .. "t", builtin.lsp_type_definitions, "Goto type definition")

	require("which-key").register({
		[code_prefix] = { name = "Code", _ = "which_key_ignore" },
		[goto_prefix] = { name = "Goto", _ = "which_key_ignore" },
	})
end

return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "VeryLazy" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

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
	},
}
