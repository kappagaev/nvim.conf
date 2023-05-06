local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true, noremap = true })
end

local function toggle_spec()
  local str = vim.fn.expand("%")
  local suffix = ".spec.ts"

  if string.sub(str, -string.len(suffix)) == suffix then
    local str1 = vim.fn.expand("%:p:r:r")
    vim.cmd("edit " .. str1 .. ".ts")
  else
    local str1 = vim.fn.expand("%:p:r")
    vim.cmd("edit " .. str1 .. ".spec.ts")
  end
end


map("n", ",t", toggle_spec)
