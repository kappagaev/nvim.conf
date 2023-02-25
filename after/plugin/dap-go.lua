require('dap-go').setup({
 dap_configurations = {
    {
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
    {
      type = "go",
      request = "launch",
      name = "Launch",
      mode = "debug",
      program = "main.go",
      console = "integratedTerminal",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      internalConsoleOptions = "neverOpen",
    }
  },
})
