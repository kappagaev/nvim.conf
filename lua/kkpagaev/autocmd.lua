local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local function send_command_to_split(command)
  vim.fn.system('tmux send-keys -t right "' .. command .. '" Enter')
end

-- au('InsertLeave', {
--   -- group = ag('yank_highlight', {}),
--   pattern = '*',
--   callback = function()
--     vim.opt_local.relativenumber = true
--   end,
-- })
--
-- au('InsertEnter', {
--   -- group = ag('yank_highlight', {}),
--   pattern = '*',
--   callback = function()
--     vim.opt_local.relativenumber = false
--   end,
-- })

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

au('BufRead', {
  pattern = '*.md',
  callback = function()
    vim.api.nvim_command('setfiletype markdown')
  end,
})

-- au('BufWritePost', {
--   pattern = 'style.css',
--   callback = function()
--     send_command_to_split("^C")
--     send_command_to_split("waybar")
--   end
-- })
