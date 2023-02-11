require("gomove").setup {
  map_defaults = false
}
local map = vim.api.nvim_set_keymap

map( "x", "<A-h>", "<Plug>GoVSMLeft", {} )
map( "x", "<A-j>", "<Plug>GoVSMDown", {} )
map( "x", "<A-k>", "<Plug>GoVSMUp", {} )
map( "x", "<A-l>", "<Plug>GoVSMRight", {} )

