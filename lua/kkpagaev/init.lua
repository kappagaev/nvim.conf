require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')
local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', 'Q', '<Cmd>bd<CR>')
map('n', '<leader>Q', '<Cmd>bd!<CR>')

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

-- vim.api.nvim_create_autocmd("FileType", {
-- pattern = "dap-repl",
-- callback = function(args)
-- vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
-- end,
-- })

require('numb').setup()
require'nvim-lastplace'.setup{}

-- require('mini.starter').setup()

