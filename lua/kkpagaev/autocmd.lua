local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au('TextYankPost', {
    group = ag('yank_highlight', {}),
    pattern = '*',
    callback = function()
      vim.highlight.on_yank { higroup = 'IncSearch', timeout = 50 }
    end,
})

au('BufWritePost', {
    group = ag('format_on_save', {}),
    pattern = '*.rb',
    callback = function()
      require("harpoon.tmux").sendCommand("{right}", "clear\n")
      require("harpoon.tmux").sendCommand("{right}", "rake \n")
    end,
})

