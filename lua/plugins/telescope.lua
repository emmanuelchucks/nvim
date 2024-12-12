-- telescope.lua
--

local live_multigrep = function(opts)
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local sorters = require("telescope.sorters")
	local config = require("telescope.config")
	local make_entry = require("telescope.make_entry")

	opts = opts or {}
	opts.cwd = opts.cwd or vim.fn.getcwd()

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Live Multi Grep",
			previewer = config.values.grep_previewer(opts),
			sorters = sorters.empty(),
			finder = finders.new_async_job({
				cwd = opts.cwd,
				entry_maker = make_entry.gen_from_vimgrep(opts),
				command_generator = function(prompt)
					if not prompt or prompt == "" then
						return nil
					end

					local pieces = vim.split(prompt, "  ")
					local args = { "rg" }

					if pieces[1] then
						table.insert(args, "-e")
						table.insert(args, pieces[1])
					end

					if pieces[2] then
						table.insert(args, "-g")
						table.insert(args, pieces[2])
					end

					return vim.list_extend(args, {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					})
				end,
			}),
		})
		:find()
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	event = { "VeryLazy" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",

		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		local wk = require("which-key")

		telescope.setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")

		wk.add({
			{ "<leader><space>", builtin.buffers, desc = "Find buffers" },

			{ "<leader>f", group = "Find" },
			{ "<leader>f/", live_multigrep, desc = "Find by grep" },
			{ "<leader>f*", builtin.grep_string, desc = "Find word under cursor" },
			{ "<leader>fb", builtin.builtin, desc = "Find builtins" },
			{ "<leader>fc", builtin.commands, desc = "Find commands" },
			{ "<leader>fd", builtin.diagnostics, desc = "Find diagnostics" },
			{ "<leader>fh", builtin.help_tags, desc = "Find help" },
			{ "<leader>fr", builtin.resume, desc = "Find resume" },
			{ "<leader>fj", builtin.jumplist, desc = "Find jumplist" },
			{ "<leader>fk", builtin.keymaps, desc = "Find keymaps" },
			{ "<leader>fo", builtin.oldfiles, desc = "Find recent files" },
			{
				"<leader>ff",
				function()
					if vim.fn.glob(vim.fn.getcwd() .. "/.git") ~= "" then
						builtin.git_files({
							show_untracked = true,
						})
					else
						builtin.find_files()
					end
				end,
				desc = "Find files",
			},
		})
	end,
}
