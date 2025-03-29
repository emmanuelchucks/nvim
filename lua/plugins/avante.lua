-- avante.lua
--

return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "Avante" },
			},
			ft = { "Avante" },
		},
	},
	config = function()
		require("avante").setup({
			vendors = {
				openrouter = {
					__inherited_from = "openai",
					endpoint = "https://openrouter.ai/api/v1",
					api_key_name = "OPENROUTER_API_KEY",
					model = "deepseek/deepseek-r1",
				},
			},
		})

		require("avante_lib").load()

		-- prefil edit window with common scenarios to avoid repeating query and submit immediately
		local prefill_edit_window = function(request)
			require("avante.api").edit()
			local code_bufnr = vim.api.nvim_get_current_buf()
			local code_winid = vim.api.nvim_get_current_win()
			if code_bufnr == nil or code_winid == nil then
				return
			end
			vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
			-- Optionally set the cursor position to the end of the input
			vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
			-- Simulate Ctrl+S keypress to submit
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
		end

		-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
		local avante_grammar_correction =
			"Correct the text to standard English, but keep any code blocks inside intact."
		local avante_keywords = "Extract the main keywords from the following text"
		local avante_code_readability_analysis = [[
			  You must identify any readability issues in the code snippet.
			  Some readability issues to consider:
			  - Unclear naming
			  - Unclear purpose
			  - Redundant or obvious comments
			  - Lack of comments
			  - Long or complex one liners
			  - Too much nesting
			  - Long variable names
			  - Inconsistent naming and code style.
			  - Code repetition
			  You may identify additional problems. The user submits a small section of code from a larger file.
			  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
			  If there's no issues with code respond with only: <OK>
		]]
		local avante_optimize_code = "Optimize the following code"
		local avante_summarize = "Summarize the following text"
		local avante_translate = "Translate this into Chinese, but keep any code blocks inside intact"
		local avante_explain_code = "Explain the following code"
		local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
		local avante_add_docstring = "Add docstring to the following codes"
		local avante_fix_bugs = "Fix the bugs inside the following codes if any"
		local avante_add_tests = "Implement tests for the following code"

		require("which-key").add({
			{ "<leader>a", group = "Avante" },
			{
				mode = { "n", "v" },
				{
					"<leader>ag",
					function()
						require("avante.api").ask({ question = avante_grammar_correction })
					end,
					desc = "avante: ask (grammar correction)",
				},
				{
					"<leader>ak",
					function()
						require("avante.api").ask({ question = avante_keywords })
					end,
					desc = "avante: ask (keywords)",
				},
				{
					"<leader>al",
					function()
						require("avante.api").ask({ question = avante_code_readability_analysis })
					end,
					desc = "avante: ask (code readability analysis)",
				},
				{
					"<leader>ao",
					function()
						require("avante.api").ask({ question = avante_optimize_code })
					end,
					desc = "avante: ask (optimize code)",
				},
				{
					"<leader>am",
					function()
						require("avante.api").ask({ question = avante_summarize })
					end,
					desc = "avante: ask (summarize text)",
				},
				{
					"<leader>an",
					function()
						require("avante.api").ask({ question = avante_translate })
					end,
					desc = "avante: ask (translate text)",
				},
				{
					"<leader>ax",
					function()
						require("avante.api").ask({ question = avante_explain_code })
					end,
					desc = "avante: ask (explain code)",
				},
				{
					"<leader>ac",
					function()
						require("avante.api").ask({ question = avante_complete_code })
					end,
					desc = "avante: ask (complete code)",
				},
				{
					"<leader>ad",
					function()
						require("avante.api").ask({ question = avante_add_docstring })
					end,
					desc = "avante: ask (docstring)",
				},
				{
					"<leader>ab",
					function()
						require("avante.api").ask({ question = avante_fix_bugs })
					end,
					desc = "avante: ask (fix bugs)",
				},
				{
					"<leader>au",
					function()
						require("avante.api").ask({ question = avante_add_tests })
					end,
					desc = "avante: ask (add tests)",
				},
			},
		})

		require("which-key").add({
			{ "<leader>a", group = "Avante" },
			{
				mode = { "v" },
				{
					"<leader>aG",
					function()
						prefill_edit_window(avante_grammar_correction)
					end,
					desc = "avante: edit (grammar correction)",
				},
				{
					"<leader>aK",
					function()
						prefill_edit_window(avante_keywords)
					end,
					desc = "avante: edit (keywords)",
				},
				{
					"<leader>aO",
					function()
						prefill_edit_window(avante_optimize_code)
					end,
					desc = "avante: edit (optimize code)",
				},
				{
					"<leader>aC",
					function()
						prefill_edit_window(avante_complete_code)
					end,
					desc = "avante: edit (complete code)",
				},
				{
					"<leader>aD",
					function()
						prefill_edit_window(avante_add_docstring)
					end,
					desc = "avante: edit (docstring)",
				},
				{
					"<leader>aB",
					function()
						prefill_edit_window(avante_fix_bugs)
					end,
					desc = "avante: edit (fix bugs)",
				},
				{
					"<leader>aU",
					function()
						prefill_edit_window(avante_add_tests)
					end,
					desc = "avante: edit (add tests)",
				},
			},
		})
	end,
}
