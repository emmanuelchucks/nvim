-- lsp.lua
--

local servers = {
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					-- Tells lua_ls where to find all the Lua files that you have loaded
					-- for your neovim configuration.
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
					-- If lua_ls is really slow on your computer, you can try this instead:
					-- library = { vim.env.VIMRUNTIME },
				},
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
	rust_analyzer = {},
	tailwindcss = {
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
					},
				},
			},
		},
	},
	tsserver = {},
}

return {
	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		event = { "VeryLazy" },
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP
			{
				"j-hui/fidget.nvim",
				opts = {},
			},

			-- Additional lua configuration, makes nvim stuff amazing!
			{
				"folke/neodev.nvim",
				opts = {},
			},

			-- Advanced Typescript LSP
			-- https://github.com/pmizio/typescript-tools.nvim
			{
				"pmizio/typescript-tools.nvim",
				opts = {},
			},
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = { "VeryLazy" },
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local builtin = require("telescope.builtin")

					require("which-key").register({
						K = { vim.lsp.buf.hover, "Hover documentation" },
						["<leader>"] = {
							c = {
								name = "Code",
								r = { vim.lsp.buf.rename, "Rename" },
								a = { vim.lsp.buf.code_action, "Code actions" },
							},
							g = {
								name = "Goto",
								d = { builtin.lsp_definitions, "Go to definition" },
								r = { builtin.lsp_references, "Go to references" },
								i = { builtin.lsp_implementations, "Go to implementation" },
								t = { builtin.lsp_type_definitions, "Go to type definition" },
							},
						},
					}, { buffer = event.buf })
				end,
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.tbl_extend(
					"force",
					vim.tbl_filter(function(server_name)
						return server_name ~= "tsserver"
					end, vim.tbl_keys(servers)),
					{
						"stylua",
						"eslint_d",
						"prettierd",
					}
				),
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})

						if server_name == "tsserver" then
							require("typescript-tools").setup({
								cmd = server.cmd,
								settings = server.settings,
								filetypes = server.filetypes,
								capabilities = capabilities,
							})
							return
						end

						require("lspconfig")[server_name].setup({
							cmd = server.cmd,
							settings = server.settings,
							filetypes = server.filetypes,
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}
