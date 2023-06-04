return {
  "ThePrimeagen/harpoon",
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = false,
  keys = {
    "<CR>",
    "m",
    "<BS>",
    "<leader>h",
    "<C-h>",
    "<C-t>",
    "<C-n>",
    "<C-s>",
  },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end

    harpoon.setup({
      tabline = false
    })

    vim.keymap.set('n', '<CR>', function()
      require("harpoon.ui").nav_next()
    end)


    vim.keymap.set('n', '<BS>', function()
      require("harpoon.ui").nav_prev()
    end)

    vim.keymap.set('n', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
    end)

    local ui = require("harpoon.ui")

    local win = require("after.plugin.winbar")

    vim.keymap.set("n", "<C-h>", function()
      win.open()
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      win.open()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<C-n>", function()
      win.open()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<C-s>", function()
      win.open()
      ui.nav_file(4)
    end)
  end
}
