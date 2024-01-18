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
  pattern = 'tmp.*.fish',
  callback = function()
    vim.keymap.set("n", "<C-v>", function()
      vim.cmd(":wq!")
    end, { buffer = true, noremap = true, silent = true })
    vim.keymap.set("i", "<C-v>", function()
      vim.cmd(":wq!")
    end, { buffer = true, noremap = true, silent = true })
    -- Get the current buffer
    local current_buffer = vim.api.nvim_get_current_buf()

    -- Get the number of lines in the buffer
    local line_count = vim.api.nvim_buf_line_count(current_buffer)

    -- Check if the buffer is empty
    if line_count == 1 and vim.api.nvim_buf_get_lines(current_buffer, 0, -1, false)[1] == '' then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
    end

    -- vim.opt_local.relativenumber = false
    -- vim.opt_local.number = false
    -- vim.opt_local.winbar = ""
    -- vim.o.winbar = ""


    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
  end,
})

-- au('BufLeave', {
--   callback = function()
--     vim.cmd('noh')
--   end,
-- })
--
