require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')
require('kkpagaev.autocmd')

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')

require("scrollbar").setup()

require('nvim-autopairs').setup()

require('numb').setup()

require("nvim-surround").setup({
})

vim.o.timeout = true
vim.o.timeoutlen = 1000

-- require'nvim-rooter'.setup()

require'colorizer'.setup()
require('Comment').setup({
toggler = {
        line = 'gcc',
        block = 'gcbc'
    },
})
