local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>lg', '<Cmd>FloatermNew --height=0.75 --width=0.75 lg<CR>')
map('n', '<leader>ld', '<Cmd>FloatermNew --height=0.75 --width=0.75 ld<CR>')
map('n', '<leader>lf', '<Cmd>FloatermNew --height=0.75 --width=0.75 lf<CR>')
map('n', 'tt', '<Cmd>FloatermToggle<CR>')

map('t', 'tt', '<Cmd>FloatermToggle<CR>')
