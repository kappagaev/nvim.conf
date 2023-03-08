local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

-- au('BufWritePost', {
-- pattern = '*.rb',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", "clear\n")
-- require("harpoon.tmux").sendCommand("{right}", "rake \n")
-- end,
-- })

-- au('BufEnter', {
-- pattern = '*.md',
-- callback = function()
-- require("barbecue.ui").toggle(false)
-- vim.cmd("ZenMode")
-- end,
-- })

au('TextChanged', {
pattern = '*.md',
callback = function()
vim.cmd('w')
end,
})

au('BufWritePost', {
  pattern = '*.cs',
  callback = function()
    require("harpoon.tmux").sendCommand("{right}", "clear\n")
    require("harpoon.tmux").sendCommand("{right}", "dotnet run \n")
  end,
})

-- au('BufWritePost', {
-- pattern = 'a',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", "clear\n")
-- require("harpoon.tmux").sendCommand("{right}", "a kkpaev react - react js json foo bar\n")
-- require("harpoon.tmux").sendCommand("{right}", "a - react js json foo bar\n")
-- end,
-- })

au('BufWritePost', {
  pattern = '*.pl',
  callback = function()
    require("harpoon.tmux").sendCommand("{right}", "clear\n")
    require("harpoon.tmux").sendCommand("{right}", "swipl \n")
    require("harpoon.tmux").sendCommand("{right}", "halt. \n")
  end,
})

-- au('BufWritePost', {
-- group = ag('format_on_save', {}),
-- pattern = '*.hs',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", ":r\n")
-- end,
-- })
