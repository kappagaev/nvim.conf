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

function buf_harpoon(name)
  local original_tabs = require('harpoon').get_mark_config().marks

  for i, tab in ipairs(original_tabs) do
    local is_current = string.match(vim.fn.bufname(), tab.filename) or vim.fn.bufname() == tab.filename
    if is_current then
      return i
    end
  end

  return nil
end

-- local mark_color = "#FFA066"
local mark_color = "#FFA066"
vim.api.nvim_set_hl(0, 'Mark1', { bg = mark_color, fg = '#000000' })
vim.api.nvim_set_hl(0, 'MarkEnd1', { fg = mark_color })

vim.api.nvim_set_hl(0, 'Mark2', { bg = "#76946A", fg = '#000000' })
vim.api.nvim_set_hl(0, 'MarkEnd2', { fg = "#76946A" })

vim.api.nvim_set_hl(0, 'Mark3', { bg = "#E46876", fg = '#000000' })
vim.api.nvim_set_hl(0, 'MarkEnd3', { fg = "#E46876" })

vim.api.nvim_set_hl(0, 'Mark4', { bg = "#E82424", fg = '#C8C093' })
vim.api.nvim_set_hl(0, 'MarkEnd4', { fg = "#E82424" })

function tabline()
  local is_modified = vim.bo.modified and "●" or ""
  local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  local extension = vim.fn.expand("%:e")
  local icon, color = require('nvim-web-devicons').get_icon(bufname, extension)
  local icon_str = icon and icon .. " " or ""
-- section_separators = { left = '', right = '' },
  local current_mark = buf_harpoon(bufname)

  if current_mark == nil then
    return " %#" .. color .. "# ".. icon_str .. "%*" ..
      bufname .. " " .. is_modified .. " %*"
  else
    return "%#Mark".. current_mark .."# " .. current_mark .. " %*" ..
      "%#MarkEnd".. current_mark .. "#" .. "" .. "%*" ..
    "%#" .. color .. "# ".. icon_str .. "%*" ..
      bufname ..
 " " .. is_modified
  end
end

-- vim.opt.showtabline = 2

vim.o.winbar = "%{%v:lua.tabline()%}"
-- vim.o.winbar = '%!v:lua.tabline()'
