local function current_time()
  -- local date = os.date('*t')
  local time = os.date("*t")
  -- return ("%02d:%02d"):format(time.hour, time.min)
  return ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec)
end
local nvimbattery = {
  function()
    return require("battery").get_status_line()
  end,
  -- color = { fg = colors.violet, bg = colors.bg },
}
local custom_codedark = require 'lualine.themes.kanagawa'

local function harp()
  local marks = require('harpoon.mark').get_mark_list()
  local result = {}
  for _, mark in ipairs(marks) do
    table.insert(result, mark.name)
  end
  return table.concat(result, ' ')
end

-- Change the background of lualine_c section for normal mode
custom_codedark.normal.c.bg = '#14141414141'
custom_codedark.normal.a = {  bg = '#FFA066', gui = 'bold', fg = '#000000' }


require('lualine').setup({
  options = {
    refesh = {
      statusline = 100000000000000,
    },
    theme = custom_codedark,
    icons_enabled = true,
    component_separators = { left = '', right = '|' },
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = ' ', right = ' '},
-- section_separators = { left = '', right = ''},

section_separators = { left = '', right = '' },
    -- theme = 'gruvbox_material',
    disabled_filetypes = {
      'NvimTree',
      'Trouble',
      'dap-repl',
      -- 'dapui_scopes',
      -- 'dapui_stacks',
      -- 'dapui_watches',
      -- 'dapui_breakpoints',

    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'diagnostics', harp },
    lualine_x = { 'filetype', current_time },
    lualine_y = { nvimbattery },
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
