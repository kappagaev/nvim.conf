require("zen-mode").setup {
  window = {
    row = 1,
    width = 1,
    height = 1,
    options = {
      signcolumn = "yes", -- disable signcolumn
      number = true, -- disable number column
      relativenumber = true, -- disable relative numbers
      cursorline = true, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = true, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
      laststatus = 0
    },
    tmux = { enabled = false },
    gitsigns = { enabled = false },
  },
  on_open = function(win)
    vim.cmd("ScrollbarHide")
  end,
  on_close = function(win)
    vim.cmd("ScrollbarShow")
  end,
}


vim.keymap.set('n', ",'", function()
  local filetype = vim.bo.filetype
  if filetype == "NvimTree" then
    vim.cmd("NvimTreeClose")
  end
  vim.cmd("ZenMode")
end)

vim.keymap.set('n', ',h', function()
  local filetype = vim.bo.filetype
  if filetype == "NvimTree" then
    vim.cmd("NvimTreeClose")
  end
  vim.cmd("ZenMode")
end)
