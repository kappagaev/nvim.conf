local q = require("vim.treesitter")
local utils = require("harpoon.utils")
local dap = require('dap')

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

local languages = {
  typescript = {
    run_all_command =
    "node --inspect -r tsconfig-paths/register -r ts-node/register ../node_modules/.bin/jest --watchAll -i",
    dap_config = {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = function()
        -- require 'dap.utils'.pick_process({filter = "pnpm run start:debug"})
        require 'dap.utils'.pick_process()
      end,
      cwd = "${workspaceFolder}",
      log = false
    },
    get_test_name = function()
      local test = get_test_at_line_number("it")
      if test == nil then
        test = get_test_at_line_number("describe")
        if test ~= nil then
          return test
        end
      else
        return test
      end
    end,
    get_file_name = function()
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
    end,
    reset_command = "q",
    get_under_cursor_command = function(run)
      local cmd =
      "node --inspect -r tsconfig-paths/register -r ts-node/register ../node_modules/.bin/jest --watchAll -i "
      if run.test ~= nil then
        cmd = cmd .. "-t '" .. run.test.name .. "'"
      end

      if run.file ~= nil then
        cmd = cmd .. " --testRegex '" .. run.file .. "'"
      end

      return cmd
    end
  },
  ruby = {
    dap_config = {
      type = 'ruby',
      name = 'debug current file',
      request = 'attach',
      port = 38698,
      server = '127.0.0.1',
      options = {
        source_filetype = 'ruby',
      },
      localfs = true,
      waiting = 1000,
    },
    get_test_name = function()
      return nil
    end,
    get_file_name = function()
      local str = vim.fn.expand("%")
      return str
    end,
    get_under_cursor_command = function(run)
      return "rdbg -c --open --port 38698 -- ruby " .. run.file
    end
  }
}




local function get_pane_count()
  local output = utils.get_os_command_output({ "tmux", "list-panes" }, ".")
  return #output
end

local function kill_pane()
  vim.fn.system('tmux kill-pane -t right')
end
-- if no split, then creates
local function reset_window(config)
  if get_pane_count() < 2 then
    vim.fn.system('tmux split-window -d -h -c "#{pane_current_path}" -l 60')
    return
  end
  if config.reset_command ~= nil then
    vim.fn.system('tmux send-keys -t right "' .. config.reset_command .. '"')
  end
end

local function send_command_to_split(command)
  vim.fn.system('tmux send-keys -t right "' .. command .. '" Enter')
end

local function run_all()
  local file_type = vim.bo.filetype
  local config = languages[file_type]
  reset_window(config)
  if config.dap_config ~= nil then
    dap.terminate()
  end
  send_command_to_split(config.run_all_command)

  if config.dap_config ~= nil then
    dap.run(config.dap_config)
  end
end

vim.keymap.set('n', '<leader>`', run_all, { noremap = true, silent = true })

local function run_at_curson()
  local file_type = vim.bo.filetype
  local config = languages[file_type]
  if config == nil then
    print("No config found for " .. file_type)
    return
  end
  if config.dap_config ~= nil then
    dap.terminate()
  end
  local run = {}
  run.test = config.get_test_name()
  local file_name = config.get_file_name()

  if file_name == nil then
    print("No spec file found")
    return
  end

  run.file = file_name

  reset_window(config)
  send_command_to_split(config.get_under_cursor_command(run))

  if config.dap_config ~= nil then
    dap.run(config.dap_config)
  end
end

-- local au = vim.api.nvim_create_autocmd

-- au("BufEnter", {
--   pattern = '*.ts',
--   callback = function()
--     vim.keymap.set('n', '`', run_at_curson, { noremap = true, silent = true })
--   end,
-- })

-- au("BufEnter", {
--   pattern = '*.http',
--   callback = function()
--     vim.keymap.set("n", "`", "<Plug>RestNvim", { noremap = true, silent = true })
--   end,
-- })


vim.keymap.set('n', '`', run_at_curson, { noremap = true, silent = true })
