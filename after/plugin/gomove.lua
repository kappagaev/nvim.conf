require("gomove").setup {
  map_defaults = false
}
local map = vim.api.nvim_set_keymap

map( "v", "H", "<Plug>GoVSMLeft", {} )
map( "v", "J", "<Plug>GoVSMDown", {} )
map( "v", "K", "<Plug>GoVSMUp", {} )
map( "v", "L", "<Plug>GoVSMRight", {} )

