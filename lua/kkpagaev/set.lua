local o = vim.o

local filetypes = {}
filetypes["dap-repl"] = false
filetypes["[dap-repl]"] = false
filetypes["dapui_watches"] = false


vim.g.copilot_filetypes = filetypes
vim.g.vimwiki_list = {
  {
    path = "/home/kkpagaev/vimwiki/",
    syntax = 'markdown',
    ext = '.md',
  },
}
vim.g.vimwiki_ext2syntax = {
  ['.md'] = 'markdown',
  ['.markdown'] = 'markdown',
  ['.mdown'] = 'markdown',
}

-- vim.g.vimwiki_key_mappings = {
-- table_mappings= 0
-- }

o.relativenumber = true
o.number = true
o.cursorline = true
local opt = vim.opt
opt.laststatus = 5

vim.opt.laststatus = 0
o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.wrap = true
o.noswapfile = true
o.nocompatible = true
o.cmdheight = 0
o.shortmess = o.shortmess .. "at"

vim.opt.diffopt = vim.opt.diffopt + "vertical"
vim.opt.display = vim.opt.display + 'lastline'


-- vim.api.nvim_set_option("clipboard", "unnamed")

-- o.clipboard:append("unnamedplus")

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.hlsearch = false
vim.opt.incsearch = true

o.ignorecase = true
o.smartcase = true

vim.opt.iskeyword:append("-")

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.crystal_define_mappings = 0


vim.o.timeout = true
vim.o.timeoutlen = 1000

-- vim.opt.statusline = " "

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

vim.opt.laststatus = 0
local str = string.rep(" ", vim.api.nvim_win_get_width(0))
vim.opt.statusline = str

