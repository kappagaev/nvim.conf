require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')
local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', 'Q', '<Cmd>bd<CR>')
map('n', '<leader>Q', '<Cmd>bd!<CR>')
-- require("barbecue").setup(
-- {

-- }
-- )
require("barbecue").setup({
 show_modified = true,
})
require 'luasnip'.filetype_extend("ruby", { "rails" })
require 'luasnip'.filetype_extend("go", { "go" })
map('n', '<leader><Shift><Tab>', '<Cmd>BufferLineCyclePrev<CR>')
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
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("scrollbar").setup()

require("nvim-tree").setup({
		sort_by = "case_sensitive",
		view = {
				adaptive_size = true,
				mappings = {
						list = {
								{ key = "h", action = "close_node" },
								{ key = "l", action = "preview" },
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
				enable = true,
				update_cwd = true
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

require("renamer").setup({})

require('indent_blankline').setup {
		char = '┊',
		show_trailing_blankline_indent = false,
}
require('packer').use({
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
})
require('gitsigns').setup()

require("lsp_signature").setup()

require("trouble").setup()

vim.api.nvim_create_autocmd("FileType", {
		pattern = "dap-repl",
		callback = function(args)
			vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
		end,
})

require('numb').setup()
require'nvim-lastplace'.setup{}

require('mini.starter').setup()

require('nvim-lightbulb').setup({
		ignore = {},
		sign = {
				enabled = true,
				priority = 10,
		},
		float = {
				enabled = false,
				text = "💡",
				win_opts = {},
		},
		virtual_text = {
				enabled = false,
				text = "💡",
				hl_mode = "replace",
		},
		status_text = {
				enabled = false,
				text = "💡",
				text_unavailable = ""
		},
		autocmd = {
				enabled = false,
				pattern = { "*" },
				events = { "CursorHold", "CursorHoldI" }
		}
})
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
