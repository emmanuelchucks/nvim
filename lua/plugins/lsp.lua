-- lsp.lua
--

return {
	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{
				-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
				-- used for completion, annotations and signatures of Neovim apis
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},

			{
				-- Allows extra capabilities provided by blink.cmp
				"saghen/blink.cmp",
			},

			{
				-- TypeScript language server extras
				"yioneko/nvim-vtsls",
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local servers = {
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas({
								replace = {
									["Wrangler CLI"] = vim.tbl_deep_extend(
										"force",
										vim.tbl_filter(function(s)
											return s.name == "Wrangler CLI"
										end, require("schemastore").json.schemas())[1] or {},
										{ fileMatch = { "wrangler.json", "wrangler.jsonc", "wrangler.toml" } }
									),
								},
							}),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemas = require("schemastore").yaml.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				tailwindcss = {
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
									{ "\\b\\w+[cC]lassName\\s*=\\s*[\"']([^\"']*)[\"']" },
									{ "\\b\\w+[cC]lassName\\s*=\\s*`([^`]*)`" },
									{ "[\\w]+[cC]lassName[\"']?\\s*:\\s*[\"']([^\"']*)[\"']" },
									{ "[\\w]+[cC]lassName[\"']?\\s*:\\s*`([^`]*)`" },
								},
							},
						},
					},
				},
				vtsls = {
					settings = {
						vtsls = { autoUseWorkspaceTsdk = true },
					},
				},
				mdx_analyzer = {},
				eslint = {},
			}

			--  This function gets run when an LSP attaches to a particular buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local builtin = require("telescope.builtin")
					local wk = require("which-key")

					wk.add({
						{
							buffer = event.buf,
							{ "<leader>f", group = "Find" },
							{ "<leader>fs", builtin.lsp_document_symbols, desc = "Find document symbols" },
							{
								"<leader>fw",
								builtin.lsp_dynamic_workspace_symbols,
								desc = "Find workspace symbols",
							},

							{ "<leader>g", group = "Goto" },
							{ "<leader>gr", vim.lsp.buf.rename, desc = "Rename" },
							{
								mode = { "n", "x" },
								{ "<leader>ga", vim.lsp.buf.code_action, desc = "Code actions" },
							},
							{ "<leader>gi", builtin.lsp_implementations, desc = "Go to implementation" },
							{ "<leader>gd", builtin.lsp_definitions, desc = "Go to definition" },
							{ "<leader>gt", builtin.lsp_type_definitions, desc = "Go to type definition" },
						},
					})
				end,
			})

			local ensure_installed = vim.tbl_keys(servers or {})

			vim.list_extend(ensure_installed, {
				"prettier",
				"eslint",
				"stylua",
			})

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
			})

			require("mason-lspconfig").setup({
				automatic_enable = vim.tbl_keys(servers or {}),
			})

			for server_name, config in pairs(servers) do
				vim.lsp.config(server_name, config)
			end
		end,
	},
}
