require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')
require('kkpagaev.autocmd')

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', 'Q', '<Cmd>bd<CR>')
map('n', '<leader>Q', '<Cmd>bd!<CR>')

require("scrollbar").setup()

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

require('nvim-autopairs').setup()

require('numb').setup()

require("nvim-surround").setup({
})

