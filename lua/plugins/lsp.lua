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
				completion = { callSnippet = "Replace" },
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
	tailwindcss = {
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "twc\\.[^`]+`([^`]*)`" },
						{ "twc\\([^`]*?\\)`([^`]*)`" },
						{ "twc\\.[^`]+\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "twc\\([^`]*?\\).*?\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "twc\\([^)]*\\)(?:<[^>]*>)?`([^`]*)`" },
						{ "twc\\([^)]*\\)\\s*\\([^)]*\\)\\s*=>\\s*\\[([^\\]]*)\\]" },
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
	prettierd = {},
	eslint = {},
	stylua = {},
	rust_analyzer = {},
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

			{
				-- TypeScript language server extras
				"yioneko/nvim-vtsls",
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

							{ "<leader>c", group = "Code" },
							{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
							{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions" },
							{ "<leader>cv", "<cmd>VtsExec source_actions<cr>", desc = "Code actions (vtsls)" },

							{ "<leader>g", group = "Goto" },
							{ "<leader>gd", builtin.lsp_definitions, desc = "Go to definition" },
							{ "<leader>gr", builtin.lsp_references, desc = "Go to references" },
							{ "<leader>gi", builtin.lsp_implementations, desc = "Go to implementation" },
							{ "<leader>gt", builtin.lsp_type_definitions, desc = "Go to type definition" },
						},
					})
				end,
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
