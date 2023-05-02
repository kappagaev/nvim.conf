local o = vim.o

local filetypes = {}
filetypes["dap-repl"] = false
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
o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.wrap = true
o.number = true
o.noswapfile = true
o.nocompatible = true
o.cursorline = true
o.cmdheight = 0
o.shortmess = o.shortmess .. "at"


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



local opt = vim.opt
opt.laststatus = 0

-- opt.autowrite = true -- Enable auto write
-- opt.completeopt = "menu,menuone,noselect"
-- opt.conceallevel = 3 -- Hide * markup for bold and italic
-- opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- Enable highlighting of the current line
-- opt.expandtab = true -- Use spaces instead of tabs
-- opt.formatoptions = "jcroqlnt" -- tcqj
-- opt.grepformat = "%f:%l:%c:%m"
-- opt.grepprg = "rg --vimgrep"
-- opt.ignorecase = true -- Ignore case
-- opt.inccommand = "nosplit" -- preview incremental substitute
-- opt.list = true -- Show some invisible characters (tabs...
-- opt.mouse = "a" -- Enable mouse mode
-- opt.number = true -- Print line number
-- opt.pumblend = 10 -- Popup blend
-- opt.pumheight = 10 -- Maximum number of entries in a popup
-- opt.relativenumber = true -- Relative line numbers

-- opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- opt.shiftround = true -- Round indent
-- opt.shiftwidth = 2 -- Size of an indent
-- opt.shortmess:append { W = true, I = true, c = true }
-- opt.showmode = false -- Dont show mode since we have a statusline
-- opt.sidescrolloff = 8 -- Columns of context
-- opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.smartcase = true -- Don't ignore case with capitals
-- opt.smartindent = true -- Insert indents automatically
-- opt.spelllang = { "en" }
-- opt.splitbelow = true -- Put new windows below current
-- opt.splitright = true -- Put new windows right of current
-- opt.tabstop = 2 -- Number of spaces tabs count for
-- opt.termguicolors = true -- True color support
-- opt.timeoutlen = 300
-- opt.undofile = true
-- opt.undolevels = 10000
-- opt.updatetime = 200 -- Save swap file and trigger CursorHold
-- opt.wildmode = "longest:full,full" -- Command-line completion mode
-- opt.winminwidth = 5 -- Minimum window width
-- opt.wrap = false -- Disable line wrap

