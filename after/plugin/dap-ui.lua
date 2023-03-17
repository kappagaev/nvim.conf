local dapui_setup = function()
  require("dapui").setup({
    layouts = {
      {
        elements = {
"scopes",
-- "breakpoints",
-- "stacks",
    "watches",
        },
        size = 20, -- 40 columns
        position = "right",
      },
      {
        elements = {
          -- "repl",
-- "console",
        },
        size = 0.30, -- 20% of total lines
        position = "bottom",
      },
    },
  })
  local dap, ui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    ui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    ui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    ui.close()
  end
end

dapui_setup()
