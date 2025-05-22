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
						show_result_in_chat = false,
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
					adapter = "anthropic",
					tools = {
						opts = {
							auto_submit_errors = true,
							auto_submit_success = true,
						},
					},
				},

				inline = {
					adapter = "anthropic",
				},
			},
		})

		require("which-key").add({
			{ "<leader>c", group = "CodeCompanion" },

			{
				mode = { "n", "v" },
				{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion: chat" },
			},

			{
				mode = { "n", "v" },
				{ "<leader>ci", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion: inline" },
			},

			{
				mode = { "n", "v" },
				{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion: actions" },
			},

			{
				mode = { "n", "v" },
				{ "<leader>ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion: toggle" },
			},

			{
				mode = { "v" },
				{ "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: add" },
			},
		})
	end,
}
