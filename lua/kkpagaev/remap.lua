local g = vim.g

local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

g.mapleader=" "
g.maplocalleader=" "

map('n', "<leader>", "")
map('n', '<C-j>', '4j') 
map('n', '<leader>d', 'Vyp')

map('n', '<c-k>', '4k')
map('n', '<c-l>', '4l')
map('n', '<c-h>', '4h')
map('n', '<c-g>', 'gcc')
map('n', '<leader>w', ':update<CR>')
map('i', 'jj', '<Esc>')
map('i', 'JJ', '<Esc>')

