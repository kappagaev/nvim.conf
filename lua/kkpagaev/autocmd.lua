local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
  end,
})

au('BufRead,BufNewFile', {
  pattern = '*.slang',
  callback = function()
    vim.o.filetype = 'slang'
  end,
})

au('BufRead,BufNewFile', {
  pattern = '*.pl',
  callback = function()
    vim.o.filetype = 'prolog'
  end,
})
-- au('BufWritePost', {
-- pattern = '*.rb',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", "clear\n")
-- require("harpoon.tmux").sendCommand("{right}", "rake \n")
-- end,
-- })

-- crystal spec

-- au('BufWritePost', {
-- pattern = '*.cr',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", "clear\n")
-- require("harpoon.tmux").sendCommand("{right}", "crystal spec\n")
-- end,
-- })

-- au('BufEnter', {
-- pattern = '*.md',
-- callback = function()
-- require("barbecue.ui").toggle(false)
-- vim.cmd("ZenMode")
-- end,
-- })

-- au('TextChanged', {
-- pattern = '*.pl',
-- callback = function()
-- vim.cmd('w')
-- end,
-- })

-- au('BufWritePost', {
-- pattern = '*.cs',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", "clear\n")
-- require("harpoon.tmux").sendCommand("{right}", "dotnet run \n")
-- end,
-- })

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
require("harpoon.tmux").sendCommand("{right}", "halt. \n")
require("harpoon.tmux").sendCommand("{right}", "halt. \n")
require("harpoon.tmux").sendCommand("{right}", "clear\n")
require("harpoon.tmux").sendCommand("{right}", "swipl -s game.pl test.pl\n")
require("harpoon.tmux").sendCommand("{right}", "test. \n\n")
end,
})

au('InsertLeave', {
pattern = '*.pl',
callback = function()
vim.cmd('w')
require("harpoon.tmux").sendCommand("{right}", "halt. \n")
require("harpoon.tmux").sendCommand("{right}", "halt. \n")
require("harpoon.tmux").sendCommand("{right}", "clear\n")
require("harpoon.tmux").sendCommand("{right}", "swipl -s game.pl test.pl\n")
require("harpoon.tmux").sendCommand("{right}", "test. \n\n")
end,
})


-- au('BufWritePost', {
-- group = ag('format_on_save', {}),
-- pattern = '*.hs',
-- callback = function()
-- require("harpoon.tmux").sendCommand("{right}", ":r\n")
-- end,
-- })
