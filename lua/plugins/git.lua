-- git.lua
--

--  This function gets run when gitsigns connects to a particular buffer.
local on_attach = function(bufnr)
	local gitsigns = package.loaded.gitsigns

	local map = function(mode, key, func, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, key, func, opts)
	end

	-- Navigation
	map("n", "]h", function()
		if vim.wo.diff then
			return "]h"
		end
		vim.schedule(function()
			gitsigns.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Next hunk" })

	local prefix = "<leader>h"

	map("n", "[h", function()
		if vim.wo.diff then
			return "[h"
		end
		vim.schedule(function()
			gitsigns.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Previous hunk" })

	-- Actions
	map("n", prefix .. "s", gitsigns.stage_hunk, { desc = "Stage hunk" })
	map("n", prefix .. "r", gitsigns.reset_hunk, { desc = "Reset hunk" })
	map("v", prefix .. "s", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage hunk" })
	map("v", prefix .. "r", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset hunk" })
	map("n", prefix .. "S", gitsigns.stage_buffer, { desc = "Stage buffer" })
	map("n", prefix .. "u", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
	map("n", prefix .. "R", gitsigns.reset_buffer, { desc = "Reset buffer" })
	map("n", prefix .. "p", gitsigns.preview_hunk, { desc = "Preview hunk" })
	map("n", prefix .. "b", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Blame line" })
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
	map("n", prefix .. "d", gitsigns.diffthis, { desc = "Diff this" })
	map("n", prefix .. "D", function()
		gitsigns.diffthis("~")
	end, { desc = "Diff this (cached)" })
	map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "inner hunk" })

	require("which-key").register({
		[prefix] = { name = "Hunk", _ = "which_key_ignore" },
	})
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
