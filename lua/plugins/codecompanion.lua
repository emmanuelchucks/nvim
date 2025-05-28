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

		-- Fidget spinner integration

		local progress = require("fidget.progress")
		local M = {}

		function M:init()
			local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "CodeCompanionRequestStarted",
				group = group,
				callback = function(request)
					local handle = M:create_progress_handle(request)
					M:store_progress_handle(request.data.id, handle)
				end,
			})

			vim.api.nvim_create_autocmd({ "User" }, {
				pattern = "CodeCompanionRequestFinished",
				group = group,
				callback = function(request)
					local handle = M:pop_progress_handle(request.data.id)
					if handle then
						M:report_exit_status(handle, request)
						handle:finish()
					end
				end,
			})
		end

		M.handles = {}

		function M:store_progress_handle(id, handle)
			M.handles[id] = handle
		end

		function M:pop_progress_handle(id)
			local handle = M.handles[id]
			M.handles[id] = nil
			return handle
		end

		function M:create_progress_handle(request)
			return progress.handle.create({
				title = " Requesting assistance (" .. request.data.strategy .. ")",
				message = "In progress...",
				lsp_client = {
					name = M:llm_role_title(request.data.adapter),
				},
			})
		end

		function M:llm_role_title(adapter)
			local parts = {}
			table.insert(parts, adapter.formatted_name)
			if adapter.model and adapter.model ~= "" then
				table.insert(parts, "(" .. adapter.model .. ")")
			end
			return table.concat(parts, " ")
		end

		function M:report_exit_status(handle, request)
			if request.data.status == "success" then
				handle.message = "Completed"
			elseif request.data.status == "error" then
				handle.message = " Error"
			else
				handle.message = "󰜺 Cancelled"
			end
		end

		M:init()
	end,
}
