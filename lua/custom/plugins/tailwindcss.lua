-- tailwindcss.lua
--

return {
<<<<<<< HEAD
	require('lspconfig').tailwindCSS.setup {
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
						{ 'cx\\(([^)]*)\\)',  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
					},
				},
			},
		},
	},
=======
>>>>>>> 37fccc6 (update with more custom plugins)
}
