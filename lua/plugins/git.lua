-- git.lua
--

--  This function gets run when gitsigns connects to a particular buffer.
local on_attach = function(bufnr)
	local gitsigns = package.loaded.gitsigns
	local wk = require("which-key")

	wk.add({
		{
			buffer = bufnr,
			{
				"ih",
				":<c-u>Gitsigns select_hunk<cr>",
				desc = "Inner hunk",
				mode = { "o", "x" },
			},
			{
				"]h",
				function()
					if vim.wo.diff then
						return "]h"
					end
					vim.schedule(function()
						gitsigns.next_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Next hunk",
			},
			{
				"[h",
				function()
					if vim.wo.diff then
						return "[h"
					end
					vim.schedule(function()
						gitsigns.prev_hunk()
					end)
					return "<Ignore>"
				end,
				desc = "Previous hunk",
			},

			{ "t", group = "Toggle" },
			{ "tb", gitsigns.toggle_current_line_blame, desc = "Toggle blame line" },
			{ "td", gitsigns.toggle_deleted, desc = "Toggle deleted" },

			{ "<leader>h", group = "Hunk" },
			{ "<leader>hs", gitsigns.stage_hunk, desc = "Stage hunk" },
			{ "<leader>hS", gitsigns.stage_buffer, desc = "Stage buffer" },
			{ "<leader>hu", gitsigns.undo_stage_hunk, desc = "Undo stage hunk" },
			{ "<leader>hr", gitsigns.reset_hunk, desc = "Reset hunk" },
			{ "<leader>hR", gitsigns.reset_buffer, desc = "Reset buffer" },
			{ "<leader>hp", gitsigns.preview_hunk, desc = "Preview hunk" },
			{ "<leader>hd", gitsigns.diffthis, desc = "Diff this" },
			{
				"<leader>hb",
				function()
					gitsigns.blame_line({ full = true })
				end,
				desc = "Blame line",
			},
			{
				"<leader>hD",
				function()
					gitsigns.diffthis("~")
				end,
				desc = "Diff this (cached)",
			},

			{
				mode = "v",
				{ "<leader>h", group = "Hunk" },
				{
					"<leader>hs",
					function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Stage hunk",
				},
				{
					"<leader>hr",
					function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Reset hunk",
				},
			},
		},
	})
end

return {
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = on_attach,
			signs_staged_enable = false,
		},
	},
}
