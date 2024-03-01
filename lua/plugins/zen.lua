return {
    "folke/zen-mode.nvim",
    lazy = false,
    keys = {
      ",,"
    },
    config = function()
      require("zen-mode").setup {
        plugins = {
          tmux = { enabled = true },
        },
        on_open = function(_)

          vim.o.cmdheight = 0
          vim.cmd 'cabbrev <buffer> q let b:quitting = 1 <bar> q'
          vim.cmd 'cabbrev <buffer> wq let b:quitting = 1 <bar> wq'
        end,
        on_close = function()
          vim.o.cmdheight = 1
          if vim.b.quitting == 1 then
            vim.b.quitting = 0
            vim.cmd 'q'
          end
        end,

        window = {
            height = 1,
          -- width = 90,
          options = { }
        },
      }
      vim.keymap.set("n", ",,", function()
        require("zen-mode").toggle()
        -- vim.opt.laststatus = 0
        -- vim.wo.cmdheight = 0
        vim.wo.wrap = false
        vim.wo.number = true
        vim.wo.rnu = true
      end)
    end
}
