local function spec()
  local file = vim.fn.expand("%")

  if string.find(file, "app/") then
    file = string.gsub(file, "app/", "spec/")
    file = string.gsub(file, ".rb", "_spec.rb")
  elseif string.find(file, "spec/") then
    file = string.gsub(file, "spec/", "app/")
    file = string.gsub(file, "_spec.rb", ".rb")
  end
  return file
end

-- local function controller()
-- end
--
-- local function model()
-- end
--
-- local function service()
-- end
--
-- local function view()
-- end

return {
  spec = spec,
  -- controller = controller,
  -- module = model,
  -- service = service,
  -- view = view
}
