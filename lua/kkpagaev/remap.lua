local g = vim.g

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
map('n', '<C-j>', '5j')

map('n', '<c-k>', '5k')
map('n', '<c-l>', '5l')
map('n', '<c-h>', '5h')
map('n', '<c-g>', 'gcc')
map('n', '<leader>w', ':update<CR>')
map('i', 'jj', '<Esc>')
map('i', 'JJ', '<Esc>')

map('n', '<leader>l', ':Format<CR>')

map('n', '<c-d>', '<c-d>zz')
map('n', '<c-u>', '<c-u>zz')

map('v', '<leader>p', '"_dP')
