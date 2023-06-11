local function spec(file)
  if string.find(file, "app/") then
    file = string.gsub(file, "app/", "spec/")
    file = string.gsub(file, ".rb", "_spec.rb")
  elseif string.find(file, "spec/") then
    file = string.gsub(file, "spec/", "app/")
    file = string.gsub(file, "_spec.rb", ".rb")
  end
  return file
end

local function test(file)
  if string.find(file, "app/") then
    file = string.gsub(file, "app/", "test/")
    file = string.gsub(file, ".rb", "_test.rb")
  elseif string.find(file, "test/") then
    file = string.gsub(file, "test/", "app/")
    file = string.gsub(file, "_test.rb", ".rb")
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
  spec = test,
  test = test,
  -- controller = controller,
  -- module = model,
  -- service = service,
  -- view = view
}
