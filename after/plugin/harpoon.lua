require("harpoon").setup({
})

local function harp()
  local foo = require('harpoon.mark').status()
  return foo
end

local active = "#D27E99"
local inactive = "#DCD7BA"

local function toggle_bar()
    if harp() == '' then
      vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = inactive})
    else
      vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = active })
    end
end

local au = vim.api.nvim_create_autocmd

au('BufEnter', {
  pattern = '*',
  callback = function()
    toggle_bar()
  end
})

vim.keymap.set('n', '<CR>', function()
  vim.cmd("NvimTreeClose")
  require("harpoon.ui").nav_next()
end)


vim.keymap.set('n', 'm', function()
  local i = require("harpoon.mark").get_current_index()
  if i == nil then
    vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = active })
    require("harpoon.mark").add_file()
  else
    vim.api.nvim_set_hl(0, 'barbecue_basename', { fg = inactive })
    require("harpoon.mark").rm_file(i)
  end
end)


vim.keymap.set('n', '<BS>', function()
  require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set('n', '<BS>', function()
  require("harpoon.ui").toggle_quick_menu()
end)

