-- colors = {
require('kanagawa').setup({
  theme = { all = { ui = { bg_gutter = 'none' } } },
  dimInactive = false,
  transparent = false,            -- do not set background color
})

vim.cmd("colorscheme kanagawa")
