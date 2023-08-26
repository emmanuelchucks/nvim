-- tailwindcss.lua
--

return {
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
}
