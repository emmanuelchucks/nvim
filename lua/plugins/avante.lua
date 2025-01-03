-- avante.lua
--

return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	build = "make",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
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
		require("avante").setup()
		require("avante_lib").load()

		local wk = require("which-key")

		wk.add({
			{
				mode = { "n", "v" },
				{ "<leader>a", group = "Avante" },
			},
		})
	end,
}
