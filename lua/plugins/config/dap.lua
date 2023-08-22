local dap = require('dap')

vim.fn.sign_define('DapBreakpoint',
  { text = '😡', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
  { text = '🔵', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
  { text = '👀', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<M-b>',
  function() require "dap".toggle_breakpoint() end)

vim.keymap.set('n', '<leader>cb',
  function() require "dap".clear_breakpoints() end)


vim.keymap.set({ 'n', 't' }, '<C-g>', function() require "dap".continue() end)
vim.keymap.set({ 'n', 't' }, '<C-c>', function() require "dap".step_over() end)
vim.keymap.set({ 'n', 't' }, "<C-r>", function() require "dap".step_into() end)
vim.keymap.set({ 'n', 't' }, "<C-l>", function() require "dap".step_out() end)

vim.keymap.set({ "n", "i", "t" }, '<M-d>', function()
  local bufname = vim.fn.expand("%:r")
  print(bufname)
  if bufname ~= "[dap-repl]" then
    -- require("dapui").toggle()
    vim.cmd("DapToggleRepl")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j", true, true, true), "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
  else
    -- require("dapui").toggle()
    vim.cmd("DapToggleRepl")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, true, true), "n", true)
    -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j", true, true, true), "n", true)
  end
  -- focus_buffer("[dap-repl]")
end)

require("dap-vscode-js").setup({
  node_path = "node",                                                                          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/kkpagaev/vscode-js-debug",                                            -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- adapters = { 'pwa-node'}, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = function()
        -- require 'dap.utils'.pick_process({filter = "pnpm run start:debug"})
        require 'dap.utils'.pick_process()
      end,
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
  {
    name = "Debug (Attach) - Remote",
    type = "chrome",
    request = "attach",
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
