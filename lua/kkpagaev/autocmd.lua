local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

-- au('BufRead', {
--   pattern = '*.fish',
--   callback = function()
--     vim.opt_local.number = false
--     vim.opt_local.relativenumber = false
--   end,
-- })
