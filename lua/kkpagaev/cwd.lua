local root_files = { "LICENSE", "package.json", "Makefile", "README.md" }
local root_dirs = { ".git", ".github" }

local function get_root(cwd)
  if not string.match(cwd, "^/home/kkpagaev") then
    return cwd
  end
  while cwd ~= "/home/kkpagaev" do
    for _, file in ipairs(root_files) do
      if vim.fn.filereadable(cwd .. "/" .. file) == 1 then
        return cwd
      end
    end

    for _, dir in ipairs(root_dirs) do
      if vim.fn.isdirectory(cwd .. "/" .. dir) == 1 then
        return cwd
      end
    end

    cwd = vim.fn.fnamemodify(cwd, ":h")
  end
end

vim.keymap.set("n", ",c", function()
  local cwd = vim.fn.expand('%:p:h')
  local root = get_root(cwd)

  vim.api.nvim_set_current_dir(root)
end)

