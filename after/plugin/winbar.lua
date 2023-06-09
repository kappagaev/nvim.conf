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
  vim.api.nvim_set_hl(0, 'Mark' .. number, { bg = color, fg = fg, bold = true })
  vim.api.nvim_set_hl(0, 'MarkEnd' .. number, { fg = color })
end

-- set_mark_color(1, "#FFA066")
set_mark_color(3, "#54546D", "#C8C093")
set_mark_color(2, "#49443C", "#C8C093")
set_mark_color(4, "#E82424", "#C8C093")
set_mark_color(1, "#2A2A37", "#C8C093")
set_mark_color(5, "#76946A")
-- set_mark_color(4, "#ffffff")
-- set_mark_color(4, "#A3D4D5")

-- vim.api.nvim_set_hl(0, 'HarpoonWindow', { bg = "#181820", fg = "#C8C093", reverse = true })
-- vim.api.nvim_set_hl(0, "WinBar", { bg = "#FFA066", fg = "#000000" })

function tabline()
  local is_modified = vim.bo.modified and "●" or ""
  -- local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  local bufname = vim.api.nvim_eval_statusline('%t', {}).str
  if bufname == "NvimTree_1" then
    return ""
    -- return " %#WinBar#  %* NvimTree"
  end
  local extension = vim.fn.expand("%:e")
  local icon, color = require('nvim-web-devicons').get_icon(bufname, extension)
  local icon_str = icon and icon .. " " or ""
  -- section_separators = { left = '', right = '' },
  local current_mark = buf_harpoon(bufname)

  if current_mark == nil then
    return " %#" .. color .. "# " .. icon_str .. "%*" ..
        bufname .. " " .. is_modified .. " %*"
  else
    return "%#WinBar#" ..
        "%#Mark" .. current_mark .. "# " .. current_mark .. " %*" ..
        "%#MarkEnd" .. current_mark .. "#" .. "" .. "%*" ..
        "%#" .. color .. "# " .. icon_str .. "%*" ..
        bufname ..
        " " .. is_modified .. " %*"
  end
end

-- vim.opt.showtabline = 2

-- vim.o.winbar = "%{%v:lua.tabline()%}"


local function open()
  vim.o.winbar = "%{%v:lua.tabline()%}"
end

local function close()
  vim.o.winbar = ""
end

local function toggle()
  if vim.o.winbar == "" then
    open()
  else
    close()
  end
end

-- vim.keymap.set('n', '&', toggle)

vim.keymap.set("n", "m", function()
  local mark = require('harpoon.mark')
  local i = mark.get_current_index()

  mark.toggle_file(i)

  open()
end)

open()
return {
  open = open,
  close = close,
  toggle = toggle
}

-- vim.o.winbar='%{%%}'
-- vim.o.winbar = '%!v:lua.tabline()'
