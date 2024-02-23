-- lsp.lua
--

local servers = {
	jsonls = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { disable = { "missing-fields" } },
		},
	},
	rust_analyzer = {},
	tailwindcss = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
				},
			},
		},
	},
	tsserver = {
		completions = {
			completeFunctionCalls = true,
		},
	},
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
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
	}, { buffer = bufnr })
end

return {
	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

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
		},
	},

	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
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
}
