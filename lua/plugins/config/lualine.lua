local custom_kanagawa = require 'lualine.themes.kanagawa'
custom_kanagawa.normal.c.bg = '#14141414141'
custom_kanagawa.normal.a = { bg = '#f05033', gui = 'bold', fg = '#000000' }
custom_kanagawa.normal.b = { bg = custom_kanagawa.normal.b.bg, gui = 'bold', fg = '#C8C093' }

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
      'neo-tree',
      winbar = {
        'harpoon',
        'dap-repl',
        'Trouble',
        'fugitive'
      }
      -- 'TelescopePrompt',

      -- 'dapui_scopes',
      -- 'dapui_stacks',
      -- 'dapui_watches',
      -- 'dapui_breakpoints',

    },
  },
  -- inactive_winbar = {
  --   lualine_a = {
  --   },
  --   lualine_b = {
  --   },
  --   lualine_c = {
  --     require("markbar.winbar").render_mark,
  --     'filename',
  --     'diff'
  --   },
  --   lualine_x = { 'filetype' },
  --   -- lualine_y = { nvimbattery },
  --   lualine_y = {},
  --   lualine_z = { }
  --
  -- },
  -- winbar = {
  --   lualine_a = {
  --   },
  --   lualine_b = {
  --   },
  --   lualine_c = {
  --     require("markbar.winbar").render_mark,
  --     'filename',
  --     'diff'
  --   },
  --   lualine_x = { 'filetype' },
  --   -- lualine_y = { nvimbattery },
  --   lualine_y = {},
  --   lualine_z = {}
  --
  -- },
  sections = {
    lualine_a = {
    },
    lualine_b = {  },
    lualine_c = {'branch', 'diff', 'diagnostics' },
    lualine_x = {
      'filetype',
      'encoding',
    },
    -- lualine_y = { nvimbattery },
    lualine_y = {},
    lualine_z = {}
  },

  inactive_sections = {

  },
  tabline = {},
  extensions = { 'fugitive' }
})
