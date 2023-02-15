local function current_time()
  -- local date = os.date('*t')
  local time = os.date("*t")
  return ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec)
end
local custom_codedark = require 'lualine.themes.codedark'

-- Change the background of lualine_c section for normal mode
custom_codedark.normal.c.bg = '#14141414141'

require('lualine').setup({
    options = {
theme = custom_codedark,
        icons_enabled = true,
        component_separators = { left = '', right = '|' },
        -- section_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},

        -- theme = 'gruvbox_material',
        disabled_filetypes = {
        'NvimTree',
        'Trouble',
        'dap-repl',
-- 'dapui_scopes',
-- 'dapui_stacks',
-- 'dapui_watches',
-- 'dapui_breakpoints',
    }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {  'branch', 'diff' },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'filetype', current_time },
        lualine_y = { 'progress' },
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
