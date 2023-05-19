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


local hl_winbar_path = 'WinBarPath'
local hl_winbar_file = 'WinBarFile'
local hl_winbar_symbols = 'WinBarSymbols'
local hl_winbar_file_icon = 'WinBarFileIcon'

function buf_harpoon()
  local original_tabs = require('harpoon').get_mark_config().marks

  for i, tab in ipairs(original_tabs) do
    local is_current = string.match(vim.fn.bufname(), tab.filename) or vim.fn.bufname() == tab.filename
    if is_current then
      return i
    end
  end

  return ""
end
vim.api.nvim_set_hl(0, 'CurrentMarkNumber', { fg = 'green' })

function tabline()
  local current_mark = buf_harpoon()
  local is_modified = vim.bo.modified and "●" or ""
  local bufname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local icon, color = require('nvim-web-devicons').get_icon(bufname, extension)
  local icon_str = icon and icon .. " " or ""

  return "%#CurrentMarkNumber# " .. current_mark .. "%*" ..
    "%#" .. color .. "# ".. icon_str .. "%*" ..
    bufname .. " " .. is_modified .. " %*"
end


-- vim.opt.showtabline = 2

vim.o.winbar = '%!v:lua.tabline()'

-- local custom_kanagawa = require 'lualine.themes.kanagawa'
-- custom_kanagawa.normal.c.bg = '#14141414141'
-- custom_kanagawa.normal.c.fg = '#14141414141'
-- custom_kanagawa.normal.a = { bg = '#FFA066', gui = 'bold', fg = '#000000' }
--
-- require('lualine').setup({
--   options = {
--     theme = custom_kanagawa,
--     icons_enabled = true,
--     global_status = false,
--     component_separators = { left = '', right = '|' },
--     -- section_separators = { left = '', right = '' },
--     -- disabled_filetypes = {
--     --   winbar = {
--     --   'NvimTree',
--     --   'Trouble',
--     --   'dap-repl',
--     --     'TelescopePrompt'
--     --   },
--     -- statusline = {
--     -- 'NvimTree',
--     -- 'Trouble',
--     -- 'dap-repl',
--     -- }
--     -- },
--   },
--   sections = {},
--   inactive_sections = {},
--   tabline = {}
--   -- tabline = {
--   --   lualine_a = {
--   --     tabline
--   --   },
--   --   lualine_c = {
--   --     {
--   --       'filetype',
--   --       file_status = false,
--   --       icon_only = true,
--   --     },
--   --     {
--   --       'filename',
--   --       use_mode_colors = false,
--   --       symbols = {
--   --         readonly = '',
--   --         modified = '●',  -- Text to show when the buffer is modified
--   --         unnamed = '',      -- Text to show for unnamed buffers.
--   --         newfile = '[New]', -- Text to show for newly created file before first write
--   --       },
--   --     }
--   --   },
--   --   lualine_x = {
--   --   },
--   --   lualine_y = {},
--   --   lualine_z = {
--   --   }
--   -- },
-- })
