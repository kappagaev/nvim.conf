local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

function create_tmux_window(command)
  return function()
    vim.fn.system("tmux new-window '" .. command .. "'")
  end
end

function fullscrean()
  vim.fn.system("tmux resize-pane -Z")
end

map("n", "<leader>u", fullscrean)
map("n", ",u", fullscrean)
-- map("n", "'", fullscrean)
