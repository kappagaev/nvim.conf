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

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { '/home/kkpagaev/.local/share/nvim/mason/bin' .. "node-debug2-adapter" },
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

dap.configurations.typescript = {
  {
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require("dap.utils").pick_process,
    sourceMaps = true,
    restart = true,
  },
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${workspaceFolder}/build/index.js",
    sourceMaps = true,
    cwd = vim.fn.getcwd(),
    protocol = "inspector",
    outFiles = { "${workspaceFolder}/build/*.js" },
  },
}
