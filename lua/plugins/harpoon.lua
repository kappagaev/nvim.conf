return {
  "ThePrimeagen/harpoon",
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = true,
  -- event = "InsertChange",
  keys = {
    "M",
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
      tabline = false,
      menu = {
        -- borderchars = {},
        border = {}
      }
    })

    -- vim.keymap.set('n', '<BS>', function()
    --   require("harpoon.ui").nav_prev()
    -- end)

    local winbar = require("markbar.winbar")

    vim.keymap.set('n', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
      winbar.clear()
    end)

    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<C-h>", function()
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<C-n>", function()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<C-s>", function()
      ui.nav_file(4)
    end)

    local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      group = group,
      callback = function()
        vim.keymap.set("n", "s", function()
          local curline = vim.api.nvim_get_current_line()
          local working_directory = vim.fn.getcwd() .. "/"
          vim.cmd("vs")
          vim.cmd("e " .. working_directory .. curline)
        end, { buffer = true, noremap = true, silent = true })
      end,
    })

    vim.api.nvim_create_autocmd("BufDelete", {
      pattern = "harpoon",
      group = group,
      callback = function()
        winbar.clear()
      end,
    })

    vim.keymap.set("n", "M", function()
      local mark = require('harpoon.mark')
      local i = mark.get_current_index()

      mark.toggle_file(i)

      winbar.clear()
      winbar.open()
    end)
  end
}
