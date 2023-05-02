require 'nvim-web-devicons'.setup {
		override = {
				zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh"
				}
		},
		color_icons = true,
		default = true,
}

require("nvim-tree").setup({
    update_cwd = false,
		sort_by = "case_sensitive",
		view = {
				adaptive_size = true,
				mappings = {
						list = {
								{ key = "c", action = "close_node" },
								{ key = "n", action = "preview" },
						},
				},
		},
		renderer = {
				group_empty = true,
		},
		filters = {
				dotfiles = true,
		},
		update_focused_file = {
				enable = false,
				update_cwd = false
		},
		diagnostics = {
				enable = true,
				show_on_dirs = false,
				debounce_delay = 50,
				icons = {
						hint = 'H',
						info = 'I',
						warning = 'W',
						error = 'E'
				}
		}
})

