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
				openrouter = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://openrouter.ai/api",
							api_key = "OPENROUTER_API_KEY",
							chat_url = "/v1/chat/completions",
						},
						schema = {
							model = {
								default = "anthropic/claude-sonnet-4",
							},
						},
					})
				end,
			},

			strategies = {
				chat = {
					tools = {
						opts = {
							auto_submit_errors = true,
							auto_submit_success = true,
						},
					},
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
