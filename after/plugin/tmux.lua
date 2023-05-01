local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

function create_tmux_window(command)
  return function()
    vim.fn.system("tmux new-window '" .. command .. "'")
  end
end

map("n", "<leader>,g", create_tmux_window("lg"))
map("n", "<leader>,d", create_tmux_window("ld"))
