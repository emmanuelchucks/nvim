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
			},
		},
	},
	config = function()
		vim.g.codecompanion_auto_tool_mode = true

		require("codecompanion").setup({
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_vars = true,
						make_slash_commands = true,
						show_result_in_chat = true,
					},
				},
			},

			adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						schema = {
							model = {
								default = "gemini-2.5-pro-preview-05-06",
							},
						},
					})
				end,
			},

			strategies = {
				chat = {
					adapter = "gemini",
				},

				inline = {
					adapter = "gemini",
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
