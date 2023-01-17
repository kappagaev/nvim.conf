local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>lg', '<Cmd>FloatermNew --height=0.75 --width=0.75 lg<CR>')
map('n', '<leader>ld', '<Cmd>FloatermNew --height=0.75 --width=0.75 ld<CR>')
map('n', '<leader>lf', '<Cmd>FloatermNew --height=0.75 --width=0.75 lf<CR>')
map('n', '<leader>rnd', '<Cmd>FloatermNew --height=0.75 --width=0.75 pnpm run start:dev<CR>')

map('n', '\\\\', '<Cmd>FloatermToggle<CR>')
map('i', '\\\\', '<Cmd>FloatermToggle<CR>')

map('t', '\\\\', '<Cmd>FloatermToggle<CR>')
map('t', '\\t', '<Cmd>FloatermNew<CR>')
map('t', '\\w', '<Cmd>FloatermKill<CR>')
map('t', '\\<Tab>', '<Cmd>FloatermNext<CR>')
