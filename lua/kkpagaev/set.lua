local o = vim.o

local filetypes = {}
filetypes["dap-repl"] = false
filetypes["dapui_watches"] = false
vim.g.copilot_filetypes = filetypes

o.relativenumber = true
o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.wrap = true
o.number = true
o.noswapfile = true
o.cursorline = true
o.cmdheight = 0
vim.api.nvim_set_option("clipboard", "unnamed")


vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

