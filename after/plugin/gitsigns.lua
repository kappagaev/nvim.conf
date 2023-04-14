require('gitsigns').setup({})

vim.keymap.set('n', '<leader>b', "<CMD>Gitsigns blame_line<CR>", { desc = '[B]lame' })
