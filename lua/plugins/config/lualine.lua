local custom_kanagawa = require 'lualine.themes.kanagawa'
custom_kanagawa.normal.c.bg = '#14141414141'
custom_kanagawa.normal.a = { bg = '#FFA066', gui = 'bold', fg = '#000000' }

require('lualine').setup({
  options = {
    globalstatus = true,
    refesh = {
      statusline = 100000000000000,
    },
    theme = custom_kanagawa,
    -- theme = 'spaceduck',
    icons_enabled = true,
    component_separators = { left = '', right = '|' },
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = ' ', right = ' '},
    -- section_separators = { left = '', right = ''},

    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- theme = 'gruvbox_material',
    disabled_filetypes = {
      'NvimTree',
      'Trouble',
      'harpoon',
      'dap-repl',
      'neo-tree',
      'fugitive'
      -- 'TelescopePrompt',

      -- 'dapui_scopes',
      -- 'dapui_stacks',
      -- 'dapui_watches',
      -- 'dapui_breakpoints',

    },
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = { 'branch' },
    lualine_c = { 'diff', 'diagnostics', },
    lualine_x = { 'filetype' },
    -- lualine_y = { nvimbattery },
    -- lualine_y = {harp  },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = { 'fugitive' }
})
