local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

local function nmap(k, v)
  map("n", k, v)
end

-- nmap("<leader>opc", ":Octo pr create")
-- nmap("<leader>oic", ":Octo issue create<CR>")
-- -- octo review start
-- nmap("<leader>ors", ":Octo review start<CR>")
-- -- octo review reviewed
-- nmap("<leader>orr", ":Octo review submit<CR>")
--
-- -- octo comment add
-- nmap("<leader>oca", ":Octo comment add<CR>")
-- -- octo comment delete
-- nmap("<leader>ocd", ":Octo comment delete<CR>")
-- -- octo review comments
-- nmap("<leader>ocl", ":Octo review comments<CR>")
--

require "octo".setup()
