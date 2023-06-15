return {
	"nvim-tree/nvim-web-devicons",
  lazy = true,
	-- event = "VeryLazy",
	opts = {
		override = {
			zsh = {
				icon = "",
				color = "#428850",
				cterm_color = "65",
				name = "Zsh",
			},
		},
		color_icons = true,
		default = true,
	},
}
