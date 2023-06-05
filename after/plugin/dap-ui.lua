local dapui_setup = function()
  require("dapui").setup({
    layouts = {
      {
        elements = {
        -- "scopes",
        -- "watches",
        },
        size = 40, -- 40 columns
        position = "right",
      },
      {
        elements = {
          "repl",
        },
        size = 0.30, -- 20% of total lines
        position = "bottom",
      },
    },
  })
end

dapui_setup()

require("nvim-dap-virtual-text").setup()

