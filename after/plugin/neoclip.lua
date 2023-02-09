require('neoclip').setup({

})

-- require('telescope').extensions.neoclip.default()
require('telescope').load_extension('neoclip')
vim.keymap.set('n', '<leader>fr', "<CMD>lua require('telescope').extensions.neoclip.default()<CR>", { desc = '[r] Find registers' })
