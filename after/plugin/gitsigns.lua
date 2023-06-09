require('gitsigns').setup({
  -- sign_priority=100
})

vim.keymap.set('n', '<leader>b', "<CMD>Gitsigns blame_line<CR>", { desc = '[B]lame' })
