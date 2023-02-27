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

local battery = require("battery")
battery.setup({
	update_rate_seconds = 30,           -- Number of seconds between checking battery status
	show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
	show_plugged_icon = false,           -- If true show a cable icon alongside the battery icon when plugged in
	show_unplugged_icon = false,         -- When true show a diconnected cable icon when not plugged in
	show_percent = true,                -- Whether or not to show the percent charge remaining in digits
    vertical_icons = true,              -- When true icons are vertical, otherwise shows horizontal battery icon
    multiple_battery_selection = 1,     -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
})

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
custom_codedark.normal.a = { bg = '#FFA066', gui = 'bold', fg = '#000000' }


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
