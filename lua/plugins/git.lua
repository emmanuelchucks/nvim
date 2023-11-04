-- git.lua
--

--  This function gets run when gitsigns connects to a particular buffer.
local on_attach = function(bufnr)
	local gitsigns = package.loaded.gitsigns
	local wk = require("which-key")

	wk.register({
		["ih"] = { ":<c-u>Gitsigns select_hunk<cr>", "Inner hunk" },
	}, { mode = { "o", "x" }, buffer = bufnr })

	wk.register({
		["]h"] = {
			function()
				if vim.wo.diff then
					return "]h"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end,
			"Next hunk",
		},
		["[h"] = {
			function()
				if vim.wo.diff then
					return "[h"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end,
			"Previous hunk",
		},
	}, { expr = true, buffer = bufnr })

	wk.register({
		["<leader>"] = {
			t = {
				name = "Toggle",
				b = { gitsigns.toggle_current_line_blame, "Toggle blame line" },
				d = { gitsigns.toggle_deleted, "Toggle deleted" },
			},
			h = {
				name = "Hunk",
				s = { gitsigns.stage_hunk, "Stage hunk" },
				S = { gitsigns.stage_buffer, "Stage buffer" },
				u = { gitsigns.undo_stage_hunk, "Undo stage hunk" },
				r = { gitsigns.reset_hunk, "Reset hunk" },
				R = { gitsigns.reset_buffer, "Reset buffer" },
				p = { gitsigns.preview_hunk, "Preview hunk" },
				d = { gitsigns.diffthis, "Diff this" },
				b = {
					function()
						gitsigns.blame_line({ full = true })
					end,
					"Blame line",
				},
				D = {
					function()
						gitsigns.diffthis("~")
					end,
					"Diff this (cached)",
				},
			},
		},
	}, { buffer = bufnr })

	wk.register({
		["<leader>h"] = {
			name = "Hunk",
			s = {
				function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				"Stage hunk",
			},
			r = {
				function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end,
				"Reset hunk",
			},
		},
	}, { mode = "v", buffer = bufnr })
end

return {
	-- Git related plugins
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		cmd = { "G", "GBrowse" },
	},

	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		-- See `:help gitsigns.txt`
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = on_attach,
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
}
