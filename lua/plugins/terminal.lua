-- terminal.lua
--

local last_term_buf = nil
local float_win = nil

local toggle_floating_term = function()
	if float_win and vim.api.nvim_win_is_valid(float_win) then
		-- Hide floating window if it exists
		vim.api.nvim_win_close(float_win, true)
		float_win = nil
		if last_term_buf then
			vim.api.nvim_set_current_buf(last_term_buf)
		end
		return
	end

	-- Use current buffer in floating window
	local current_buf = vim.api.nvim_get_current_buf()
	last_term_buf = current_buf

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)

	float_win = vim.api.nvim_open_win(current_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})
end

local terminal_buffers = {}
local terminal_windows = {}

local toggle_terminals = function()
	if next(terminal_windows) ~= nil then
		-- Hide all terminal windows
		for _, win in pairs(terminal_windows) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
		terminal_windows = {}
		return
	end

	-- Create terminal windows if they don't exist
	if #terminal_buffers == 0 then
		-- Create vertical split terminal
		vim.cmd.vnew()
		vim.cmd.terminal()
		vim.cmd.wincmd("H")
		vim.api.nvim_win_set_width(0, 50)
		table.insert(terminal_buffers, vim.api.nvim_get_current_buf())
		table.insert(terminal_windows, vim.api.nvim_get_current_win())

		-- Create horizontal split terminal
		vim.cmd.new()
		vim.cmd.terminal()
		table.insert(terminal_buffers, vim.api.nvim_get_current_buf())
		table.insert(terminal_windows, vim.api.nvim_get_current_win())

		-- Create another split terminal
		vim.cmd.split()
		vim.cmd.terminal()
		table.insert(terminal_buffers, vim.api.nvim_get_current_buf())
		table.insert(terminal_windows, vim.api.nvim_get_current_win())
	else
		-- Show existing terminal buffers in original layout
		-- First terminal (vertical split)
		vim.cmd.vsplit()
		vim.api.nvim_set_current_buf(terminal_buffers[1])
		vim.cmd.wincmd("H")
		vim.api.nvim_win_set_width(0, 50)
		table.insert(terminal_windows, vim.api.nvim_get_current_win())

		-- Second terminal (horizontal split)
		vim.cmd.split()
		vim.api.nvim_set_current_buf(terminal_buffers[2])
		table.insert(terminal_windows, vim.api.nvim_get_current_win())

		-- Third terminal (another split)
		vim.cmd.split()
		vim.api.nvim_set_current_buf(terminal_buffers[3])
		table.insert(terminal_windows, vim.api.nvim_get_current_win())
	end
end

local wk = require("which-key")

wk.add({
	{ "<leader>tt", toggle_terminals, desc = "Toggle terminals" },
	{ "<leader>tf", toggle_floating_term, desc = "Toggle floating terminal" },
	{ "<esc><esc>", "<c-\\><c-n>", desc = "Escape to normal mode", mode = "t", hidden = true },
})

return {}
