-- lsp.lua
--

local servers = {
	astro = {},
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
	tsserver = {
		completions = {
			completeFunctionCalls = true,
		},
	},
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
				tag = "legacy",
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
}
