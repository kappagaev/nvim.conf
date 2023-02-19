local lualine = require("lualine")

require("zen-mode").setup {
    window = {
        row = 1,
        width = 1,
        height = 1,
        options = {
            signcolumn = "yes", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false, -- disable cursorline
            cursorcolumn = false, -- disable cursor column
            foldcolumn = "0", -- disable fold column
            list = false, -- disable whitespace characters
        },
    },
    plugins = {
        options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            laststatus = 0
        },
        twilight = { enabled = false },
        tmux = { enabled = true },
gitsigns = { enabled = false },
    },

    on_open = function(win)
      vim.cmd("ScrollbarHide")
      -- vim.cmd("IndentBlanklineDisable")
      vim.cmd("Barbecue hide")

      lualine.hide()
      vim.o.statusline = " "
      vim.o.cmdheight = 1
-- vim.cmd("colorscheme " .. "spaceduck")
    end,
    on_close = function(win)
      vim.cmd("ScrollbarShow")
      -- vim.cmd("IndentBlanklineEnable")
      vim.cmd("Barbecue show")
      lualine.hide({ unhide = true })
      vim.o.cmdheight = 0



-- vim.cmd("colorscheme " .. "kanagawa")
    end,
}

require("twilight").setup {
    context = 18,
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
    },
}

vim.keymap.set('n', '<leader>j', function()
  local filetype = vim.bo.filetype
  if filetype == "NvimTree" then
    vim.cmd("NvimTreeClose")
  end
  vim.cmd("ZenMode")
end)
