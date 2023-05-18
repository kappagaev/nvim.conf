require("harpoon").setup({
  -- tabline = true,
})

local active = "#A8A093"
local inactive = "#DCD7BA"

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
  vim.cmd("NvimTreeClose")
  require("harpoon.ui").nav_prev()
end)

vim.keymap.set('n', '<leader>h', function()
  require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set('n', '<C-c>', function()
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

-- local mark = require("harpoon.mark")
local ui = require("harpoon.ui")


vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)



