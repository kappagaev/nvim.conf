local dap = require('dap')
-- dap.defaults.fallback.force_external_terminal = true
-- dap.defaults.fallback.terminal_win_cmd = 'belowright new'
--
-- dap.defaults.fallback.external_terminal = {
-- command = '/usr/bin/kitty';
-- }dap.defaults.fallback.force_external_terminal = true
vim.fn.sign_define('DapBreakpoint',
  { text = '💀', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
  { text = '🔵', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
  { text = '👀', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<A-b>',
  function() require "dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH',
  ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], {})

vim.keymap.set({ 'n', 't' }, '<A-k>', function() require "dap".step_out() end)
vim.keymap.set({ 'n', 't' }, "<A-l>", function() require "dap".step_into() end)
vim.keymap.set({ 'n', 't' }, '<A-j>', function() require "dap".step_over() end)
vim.keymap.set({ 'n', 't' }, '<A-h>', function() require "dap".continue() end)
vim.keymap.set('n', '<leader>dr', function() require "dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require "dap".terminate() end)
vim.keymap.set('n', '<leader>rr', function() require "dap".run_last() end)
vim.keymap.set('n', '<leader>dR',
  function() require "dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de',
  function() require "dap".set_exception_breakpoints({ "all" }) end)
-- vim.keymap.set('n', '<leader>da', function() require "debugHelper".attach() end)
-- vim.keymap.set('n', '<leader>dA',
-- function() require "debugHelper".attachToRemote() end)
vim.keymap
    .set('n', '<leader>di', function() require "dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function()
  local widgets = require "dap.ui.widgets";
  widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')

vim.keymap.set('n', '<leader>rd', function()
  require("dap-go").debug_test()
end, { desc = "Run Debug, current pointer test" })

vim.keymap.set('n', '<leader>rr', function()
  require("dap-go").debug_last_test()
end, { desc = "ReRun last debug test" })

vim.keymap.set('n', '<leader>du', function()
  vim.cmd("NvimTreeClose")
  require("dapui").toggle({});
end)

require('persistent-breakpoints').setup {
  save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
  -- when to load the breakpoints? "BufReadPost" is recommanded.
  load_breakpoints_event = nil,
  -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
  perf_record = false,
}

require("dap-vscode-js").setup({
  node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/kkpagaev/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- adapters = { 'pwa-node'}, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      name = "Debug Jest E2E Tests --watch",
      type = "pwa-node",
      request = "launch",
      runtimeExecutable = "node",
      runtimeArgs = {
        "--inspect-brk",
        "/usr/local/bin/jest",
        "--runInBand",
        "--config",
        "${workspaceFolder}/test/jest-e2e.json",
        "--watch"
      },
      console = "integratedTerminal",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      internalConsoleOptions = "neverOpen",
      port = 9229,
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch project",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "pnpm",
      runtimeArgs = {
        "debug",
      },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
end
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

require("dap").configurations.vue = { -- change this to javascript if needed
  -- {
  -- name = "Debug Chrome",
  -- type = "chrome",
  -- request = "launch",
  -- url = "http://localhost:3001",
  -- webRoot = "${workspaceFolder}",
  -- runtimeExecutable = "/usr/bin/google-chrome-stable",
  -- runtimeArgs = { "--remote-debugging-port=9222" },
  -- },
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    -- sourceMaps = true,
    -- breakOnLoad = true,
    -- trace = true,
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}

require("dap").configurations.typescriptreact = { -- change this to javascript if needed
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
    sourceMaps = true,
    trace = true,
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}
