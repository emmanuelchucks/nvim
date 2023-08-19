-- rest.lua
--

return {
	'rest-nvim/rest.nvim',
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { 'http', 'json' },
		}
	end,
}
