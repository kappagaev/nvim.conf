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
    disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
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

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
