-- rest.lua
--

return {
	'rest-nvim/rest.nvim',
	config = function()
		require('rest-nvim').setup {
			result_split_horizontal = true,
			result_split_in_place = true,
		}

		vim.keymap.set('n', '<leader>rr', require('rest-nvim').run, { desc = '[R]un [R]request' })
		vim.keymap.set('n', '<leader>rp', function()
			require('rest-nvim').run(true)
		end, { desc = '[R]un [P]review' })
	end,
}
