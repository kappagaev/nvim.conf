local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], {})

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
map('v', "j", "h")
map('v', "h", "j")

map('v', "H", "j")


map('n', "H", "j")
map('n', "T", "k")

map('s', "H", "H")
map('s', "T", "T")

map('v', "t", "k")
map('v', "T", "{")
map('v', "k", "t")

map('n', "j", "h")
map('n', "h", "j")

map('n', "t", "k")
map('n', "k", "t")
-- map('n', '<C-j>', '5j')
map('i', "<C-g>d", "<Left>")
map('i', "<C-g>h", "<Down>")
map('i', "<C-g>t", "<Up>")
map('i', "<C-g>n", "<Right>")
-- map('n', '<c-k>', '5k')
-- map('n', '<c-l>', '5l')
-- map('n', '<c-h>', '5h')
-- map('n', '<c-g>', 'gcc')
-- map('n', '<leader>w', ':update<CR>')
-- map('i', 'hh', '<Esc>')
-- map('i', 'HH', '<Esc>')
map("n", "YY", "va{Vy")

vim.api.nvim_set_keymap('n', ',', '<C-w>', { noremap = true })
-- vim.api.nvim_set_keymap('n', ",h", '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', ",d", ':q<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '>', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', '<', '<<', { noremap = true })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map('i', '<A-h>', '<c-o>h')
map('i', '<A-j>', '<c-o>j')
map('i', '<A-k>', '<c-o>k')
map('i', '<A-l>', '<c-o>l')
map('i', '<A-o>', '<c-o>o')
-- map('n', 'gx', ":!open <c-r><c-a>")
-- vim.keymap.nnoremap { 'gx', [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]] }
map('n', '<leader>l', ':Format<CR>')
map('n', '<leader>i', ':TypescriptAddMissingImports<CR>')

-- map('n', '<c-d>', '18j')
-- map('n', '<c-u>', '18k')

map('v', '<leader>p', '"_dP')

-- map('n', '<leader>w', ":w<CR>")

map('n', 'go', '<c-o>')
map('n', 'gi', '<c-i>')

-- map('n', '<c-e>', '<c-d>')
-- map('n', '<c-g>', '<c-u>')

map('n', "yf", 'jgg"+yG<c-o>k')

map('n', 'U', '<c-r>')

map('v', "<leader>y", '"+y')
map('n', "<leader>y", '"+y')

map('n', "<leader>p", '"+p')
map('v', "<leader>p", '"+p')

map('n', "<leader>o", ':w<CR>')
map('n', ",.", ':w<CR>')


map('s', "h", "h")
map('s', "t", "t")
map('s', "j", "j")
map('s', "k", "k")

map('s', "H", "H")
map('s', "T", "T")
map('s', "J", "J")
map('s', "K", "K")
-- _G.main_func = function()
-- vim.cmd("VimwikiToggleListItem")
-- vim.go.operatorfunc = "v:lua.main_func"
-- return "g@l"
-- end

vim.keymap.set("i", '<C-F>', 'copilot#Accept()', { expr = true, silent = true, script = true })

-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- vim.keymap.set("n", "glt", main_func, { expr = true, silent = true})
vim.keymap.set("n", "glt", ":VimwikiToggleListItem<CR>", { silent = true })
-- vim.keymap.set('i','<C-]>', '<esc>f\\|ni', { silent = true })
--

vim.keymap.set("n", "<leader>mr", function()
  require("zen-mode").toggle()
  vim.cmd "CellularAutomaton make_it_rain"
end)


vim.keymap.set("i", "<C-BS>", "<C-w>", {})

vim.keymap.set('n', ';', '<C-W>w')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

-- vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", { silent = true })

vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })
