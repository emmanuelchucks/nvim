-- codecompanion.lua
--

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "codecompanion" },
		},
		{
			"ravitemer/mcphub.nvim",
			build = "bundled_build.lua",
			opts = {
				use_bundled_binary = true,
				auto_approve = true,
				make_vars = true,
				make_slash_commands = true,
			},
		},
	},
	config = function()
		vim.g.codecompanion_auto_tool_mode = true

		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "anthropic",
					tools = {
						["mcp"] = {
							callback = function()
								return require("mcphub.extensions.codecompanion")
							end,
							description = "Call tools and resources from the MCP Servers",
						},
					},
				},
				inline = {
					adapter = "anthropic",
				},
			},
		})

		require("which-key").add({
			{ "<leader>cc", group = "CodeCompanion" },
			{
				mode = { "n", "v" },
				{
					"<leader>ccc",
					"<cmd>CodeCompanionChat<cr>",
					desc = "CodeCompanion: chat",
				},
			},
			{
				mode = { "n", "v" },
				{
					"<leader>cci",
					"<cmd>CodeCompanion<cr>",
					desc = "CodeCompanion: inline",
				},
			},
			{
				mode = { "n", "v" },
				{
					"<leader>cca",
					"<cmd>CodeCompanionActions<cr>",
					desc = "CodeCompanion: actions",
				},
			},
			{
				mode = { "n", "v" },
				{
					"<leader>cct",
					"<cmd>CodeCompanionChat Toggle<cr>",
					desc = "CodeCompanion: toggle",
				},
			},
			{
				mode = { "v" },
				{
					"ga",
					"<cmd>CodeCompanionChat Add<cr>",
					desc = "CodeCompanion: add",
				},
			},
		})
	end,
}
