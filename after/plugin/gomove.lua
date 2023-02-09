require("gomove").setup {
}
local map = vim.api.nvim_set_keymap

map( "x", "<C-h>", "<Plug>GoVSMLeft", {} )
map( "x", "<C-j>", "<Plug>GoVSMDown", {} )
map( "x", "<C-k>", "<Plug>GoVSMUp", {} )
map( "x", "<C-l>", "<Plug>GoVSMRight", {} )

