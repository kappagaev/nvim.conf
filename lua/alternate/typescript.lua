local function get_base_nest_name(file)
  if string.find(file, ".spec.ts") then
    file = string.gsub(file, ".spec.ts", ".ts")
  end
  local suffixes = { "%.module%.ts", "%.service%.ts", "%.controller%.ts", "%.entity%.ts" }

  for i = 1, #suffixes do
    local suffix = suffixes[i]
    if string.find(file, suffix) then
      return string.sub(file, 0, string.len(file) - string.len(suffix) + 2)
    end
  end
end

local function spec()
  local str = vim.fn.expand("%")
  local suffix = ".spec.ts"

  if string.sub(str, -string.len(suffix)) == suffix then
    local str1 = vim.fn.expand("%:p:r:r")
    return str1 .. ".ts"
  else
    local str1 = vim.fn.expand("%:p:r")
    return str1 .. ".spec.ts"
  end
end


local function controller()
  local base_name = get_base_nest_name(vim.fn.expand("%"))

  return base_name .. ".controller.ts"
end

local function module()
  local base_name = get_base_nest_name(vim.fn.expand("%"))

  return base_name .. ".module.ts"
end

local function service()
  local base_name = get_base_nest_name(vim.fn.expand("%"))

  return base_name .. ".service.ts"
end

return {
  spec = spec,
  controller = controller,
  module = module,
  service = service
}
