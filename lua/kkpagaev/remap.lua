local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
-- map('n', '<C-j>', '5j')

-- map('n', '<c-k>', '5k')
-- map('n', '<c-l>', '5l')
-- map('n', '<c-h>', '5h')
-- map('n', '<c-g>', 'gcc')
map('n', '<leader>w', ':update<CR>')
map('i', 'jj', '<Esc>')
map('i', 'JJ', '<Esc>')
-- map('n', 'gx', ":!open <c-r><c-a>")
-- vim.keymap.nnoremap { 'gx', [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]] }
map('n', '<leader>l', ':Format<CR>')

map('n', '<c-d>', '20j')
map('n', '<c-u>', '20k')

map('v', '<leader>p', '"_dP')

map('n', '<leader>w', ":w<CR>")
