
require("toggleterm").setup()

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

vim.keymap.set('t', '<c-t>', '<Cmd>ToggleTermToggleAll<CR>')
vim.keymap.set('n', '<c-t>', '<Cmd>ToggleTermToggleAll<CR>')
vim.keymap.set('n', '<leader>t', '<Cmd>ToggleTerm direction=vertical size=50<CR>')
