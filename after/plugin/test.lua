local q = require("vim.treesitter")
local utils = require("harpoon.utils")

local function i(...)
  print(vim.inspect(...))
end

local function get_jest_tests(function_name)
  if function_name == nil then
    function_name = "it"
  end
  local bufnr = vim.api.nvim_get_current_buf()

  local language_tree = vim.treesitter.get_parser(bufnr, "typescript")
  local sysntax_tree = language_tree:parse()[1]
  local root = sysntax_tree:root()

  local query = vim.treesitter.query.parse("typescript", [[
  (expression_statement
    (call_expression
      function: ((identifier) @function (#match? @function "]] .. function_name .. [["))
      arguments: (arguments
        (string
          (string_fragment) @name
        )
      )
    ) @test (#offset! @test)
  )
  ]])

  local tests = {}
  for _, captures, metadata in query:iter_matches(root, bufnr) do
    tests[#tests + 1] = {
      name = q.get_node_text(captures[2], bufnr),
      range = metadata[3]['range'],
    }
  end

  return tests
end


local function get_test_at_line_number(function_name)
  -- curson line number
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local tests = get_jest_tests(function_name)
  for _, test in ipairs(tests) do
    local start = test.range[1]
    local ends = test.range[3] + 1
    if line_number > start and line_number <= ends then
      return test
    end
  end
end


local function get_pane_count()
  local output = utils.get_os_command_output({ "tmux", "list-panes" }, ".")
  return #output
end

local function kill_pane()
  vim.fn.system('tmux kill-pane -t right')
end
-- if no split, then creates
local function reset_window()
  if get_pane_count() >= 2 then
    vim.fn.system('tmux send-keys -t right "q"')
  else
    vim.fn.system('tmux split-window -d -h -c "#{pane_current_path}" -l 60')
  end
end

local function send_command_to_split(command)
  vim.fn.system('tmux send-keys -t right "' .. command .. '" Enter')
end

local function get_spec()
  local str = vim.fn.expand("%")
  local suffix = ".spec.ts"

  if string.sub(str, -string.len(suffix)) == suffix then
    return vim.fn.expand("%:p")
  elseif string.sub(str, -string.len(".ts")) == ".ts" then
    local str1 = vim.fn.expand("%:p:r")
    return str1 .. ".spec.ts"
  else
    return nil
  end
end



local function run_all()
  reset_window()
  send_command_to_split("npx jest --watchAll -i")
end

vim.keymap.set('n', '<leader>`', run_all, { noremap = true, silent = true })

local function run_at_curson()
  local dap = require('dap')
  dap.terminate()
  local cmd = "node --inspect -r tsconfig-paths/register -r ts-node/register ../node_modules/.bin/jest --watchAll -i "
  local test = get_test_at_line_number()
  if test == nil then
    test = get_test_at_line_number("describe")
    if test ~= nil then
      cmd = cmd .. "-t '" .. test.name .. "'"
    end
  else
    cmd = cmd .. "-t '" .. test.name .. "'"
  end
  local file_name = get_spec()

  if file_name == nil then
    print("No spec file found")
    return
  end

  reset_window()
  cmd = cmd .. " --testRegex '" .. file_name .. "'"
  send_command_to_split(cmd)

  local config = ({
    type = "pwa-node",
    request = "attach",
    name = "Attach",
    processId = function()
      -- require 'dap.utils'.pick_process({filter = "pnpm run start:debug"})
      require 'dap.utils'.pick_process()
    end,
    cwd = "${workspaceFolder}",
    log = false
  })
  dap.run(config)
end

local au = vim.api.nvim_create_autocmd

au("BufEnter", {
  pattern = '*.spec.ts',
  callback = function()
    vim.keymap.set('n', '`', run_at_curson, { noremap = true, silent = true })
  end,
})

au("BufEnter", {
  pattern = '*.http',
  callback = function()
    vim.keymap.set("n", "`", "<Plug>RestNvim", { noremap = true, silent = true })
  end,
})
