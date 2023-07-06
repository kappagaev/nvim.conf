local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end


local langs = {
  typescript = require("alternate.typescript"),
  ruby = require("alternate.ruby")
}

local function toggle_module()
  local file_type = vim.bo.filetype
  local conf = langs[file_type]

  if conf == nil then
    print("No config found for " .. file_type)
    return
  end

  if conf.module == nil then
    print("Go to module is not supported for " .. file_type)
    return
  end

  local alter_name = conf.module()

  if alter_name == nil then

  else
    vim.cmd("edit " .. alter_name)
  end
end


local function toggle_service()
  local file_type = vim.bo.filetype
  local conf = langs[file_type]

  if conf == nil then
    print("No config found for " .. file_type)
    return
  end

  if conf.service == nil then
    print("Go to service is not supported for " .. file_type)
    return
  end

  local alter_name = conf.service()
  vim.cmd("edit " .. alter_name)
end

local function toggle_controller()
  local file_type = vim.bo.filetype
  local conf = langs[file_type]

  if conf == nil then
    print("No config found for " .. file_type)
    return
  end

  if conf.controller == nil then
    print("Go to controller is not supported for " .. file_type)
    return
  end

  local alter_name = conf.controller()
  vim.cmd("edit " .. alter_name)
end

local function toggle_spec()
  local file_type = vim.bo.filetype
  local conf = langs[file_type]

  if conf == nil then
    print("No config found for " .. file_type)
    return
  end

  if conf.spec == nil then
    print("Toggle spec is not supported for " .. file_type)
    return
  end

  local file = vim.fn.expand("%")
  local alter_name = conf.spec(file)
  vim.cmd("edit " .. alter_name)
end

-- map("n", ",t", toggle_spec)
-- map("n", ",c", toggle_controller)
-- map("n", ",m", toggle_module)
-- map("n", ",s", toggle_service)
--
-- map("n", ",T", function()
--   vim.cmd("vsplit")
--   vim.cmd("wincmd p")
--   toggle_spec()
-- end)
