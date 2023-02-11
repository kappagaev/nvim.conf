local function current_time()
-- local date = os.date('*t')
  local time = os.date("*t")
  return  ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec)
end

require('lualine').setup({
    options = {
        icons_enabled = false,
        component_separators = { left = '|', right = '|' },
        -- section_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},

        -- theme = 'gruvbox_material',
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype', current_time},
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
