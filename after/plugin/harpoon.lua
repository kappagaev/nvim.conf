require("harpoon").setup({
})

local function harp()
  local foo = require('harpoon.mark').status()
  return foo
end

local active = "#A8A093"
local inactive = "#DCD7BA"

local function toggle_bar()
  if harp() == '' then
    vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = inactive })
  else
    vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = active })
  end
end

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

vim.keymap.set('n', '<CR>', function()
  vim.cmd("NvimTreeClose")
  require("harpoon.ui").nav_next()
end)


vim.keymap.set('n', 'm', function()
  local mark = require('harpoon.mark')
  local i = mark.get_current_index()
  if i == nil then
    vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg = active })
  else
    vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg = inactive })
  end
  mark.toggle_file(i)
end)


vim.keymap.set('n', '<BS>', function()
  require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set('n', '<BS>', function()
  require("harpoon.ui").toggle_quick_menu()
end)

au('BufEnter', {
  pattern = '*',
  callback = function()
    local mark = require('harpoon.mark')
    local i = mark.get_current_index()
    if i == nil then
      vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg = inactive })
    else
      vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg = active })
    end
  end
})
