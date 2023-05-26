function buf_harpoon()
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
local function set_mark_color(number, color, fg)
  if not fg then
    fg = "#000000"
  end
  vim.api.nvim_set_hl(0, 'Mark' .. number, { bg = color, fg = fg })
  vim.api.nvim_set_hl(0, 'MarkEnd' .. number, { fg = color })
end

-- set_mark_color(1, "#FFA066")
set_mark_color(1, "#54546D", "#C8C093")
set_mark_color(2, "#76946A")
set_mark_color(3, "#E82424", "#C8C093")
set_mark_color(4, "#7E9CD8")
-- set_mark_color(4, "#A3D4D5")
set_mark_color(5, "#49443C", "#C8C093")

-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#FFA066", fg = "#000000" })

function tabline()
  local is_modified = vim.bo.modified and "●" or ""
  -- local bufname = vim.api.nvim_eval_statusline('%t', {}).str
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
    return "%#WinBar#" ..
      "%#Mark".. current_mark .."# " .. current_mark .. " %*" ..
      "%#MarkEnd".. current_mark .. "#" .. "" .. "%*" ..
    "%#" .. color .. "# ".. icon_str .. "%*" ..
      bufname ..
 " " .. is_modified .. " %*"
  end
end

-- vim.opt.showtabline = 2

vim.o.winbar = "%{%v:lua.tabline()%}"
-- vim.o.winbar = '%!v:lua.tabline()'
