-- local function current_time()
-- local time = os.date("*t")
-- return ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec)
-- end
-- local nvimbattery = {
-- function()
-- return require("battery").get_status_line()
-- end,
-- }

-- local battery = require("battery")
-- battery.setup({
-- update_rate_seconds = 30,           -- Number of seconds between checking battery status
-- show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
-- show_plugged_icon = false,           -- If true show a cable icon alongside the battery icon when plugged in
-- show_unplugged_icon = false,         -- When true show a diconnected cable icon when not plugged in
-- show_percent = true,                -- Whether or not to show the percent charge remaining in digits
-- vertical_icons = true,              -- When true icons are vertical, otherwise shows horizontal battery icon
-- multiple_battery_selection = 1,     -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
-- })


local custom_kanagawa = require 'lualine.themes.kanagawa'
custom_kanagawa.normal.c.bg = '#14141414141'
custom_kanagawa.normal.c.fg = '#14141414141'
custom_kanagawa.normal.a = { bg = '#FFA066', gui = 'bold', fg = '#000000' }

require('lualine').setup({
  options = {
    -- refesh = {
    --   statusline = 100000000000000,
    -- },
    theme = custom_kanagawa,
    icons_enabled = true,
    global_status = false,
    component_separators = { left = '', right = '|' },
    -- section_separators = { left = '', right = '' },
    -- disabled_filetypes = {
    --   winbar = {
    --   'NvimTree',
    --   'Trouble',
    --   'dap-repl',
    --     'TelescopePrompt'
    --   },
      -- statusline = {
      -- 'NvimTree',
      -- 'Trouble',
      -- 'dap-repl',
      -- }
    -- },
  },
  sections = {},
  inactive_sections = {},
  -- sections = {
  --   lualine_a = { {
  --     'mode',
  --   }
  --   },
  --   lualine_b = { 'branch', 'diff' },
  --   lualine_c = { 'diagnostics', },
  --   lualine_x = { 'filetype' },
  --   -- lualine_y = { nvimbattery },
  --   -- lualine_y = {harp  },
  --   lualine_y = { 'searchcount' },
  --   lualine_z = { 'location' }
  -- },
  -- inactive_sections = {
  --   lualine_a = {},
  --   lualine_b = {},
  --   lualine_c = { 'filename' },
  --   lualine_x = { 'location' },
  --   lualine_y = {},
  --   lualine_z = {}
  -- },
  tabline = {
    lualine_c = {
      {
        'filetype',
        file_status = false,
        icon_only = true,
      },
      {
        'filename',
        use_mode_colors = false,
        symbols = {
          readonly = '',
          modified = '●',    -- Text to show when the buffer is modified
          unnamed = '', -- Text to show for unnamed buffers.
          newfile = '[New]',   -- Text to show for newly created file before first write
        },
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  -- extensions = { 'fugitive' },
})
