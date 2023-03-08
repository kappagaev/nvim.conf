local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.g.floaterm_width = 0.75
vim.g.floaterm_height = 0.75
vim.g.floaterm_title = ''


map('n', '<leader>lg', '<Cmd>FloatermNew --height=0.9 --width=0.9 lg<CR>')
map('n', '<leader>ld', '<Cmd>FloatermNew --height=0.9 --width=0.9 ld<CR>')
map('n', '<leader>lf', '<Cmd>FloatermNew --height=0.9 --width=0.9 lf<CR>')
map('n', '<leader>ls', '<Cmd>FloatermNew --height=0.9 --width=0.9 spt<CR>')
map('n', '<leader>la', '<Cmd>FloatermNew --height=0.9 --width=0.9 adl<CR>')

map('n', '\\', '<Cmd>FloatermToggle<CR>')

map('t', '\\\\', '<Cmd>FloatermToggle<CR>')
map('t', '\\t', '<Cmd>FloatermNew --height=0.75 --width=0.75<CR>')
map('t', '\\w', '<Cmd>FloatermKill<CR>')
map('t', '\\<Tab>', '<Cmd>FloatermNext<CR>')



vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
