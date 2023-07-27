local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

vim.api.nvim_set_keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]], {})

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
-- map('v', "j", "h")
-- map('v', "h", "j")
--
-- map('v', "H", "j")

map('n', '&', 'gt')
map('t', '&', function ()
  vim.cmd("normal! gt")
end)


map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- map('n', "H", "j")
-- map('n', "T", "k")
--
-- map('s', "H", "H")
-- map('s', "T", "T")
--
-- map('v', "t", "k")
-- map('v', "T", "{")
-- map('v', "k", "t")
--
-- map('n', "j", "h")
-- map('n', "h", "j")
--
-- map('n', "t", "k")
-- map('n', "k", "t")

-- map('n', '<C-j>', '5j')
map('i', "<C-g>", "<C-o>")
map('i', "<C-d>", "<M-d>")
map('i', "<C-l>", "<Right>")

map('n', "t", "f")
map('n', "f", "t")

map('n', "T", "F")
map('n', "F", "T")


-- map('i', "<C-g>h", "<Down>")
-- map('i', "<C-g>t", "<Up>")
-- map('i', "<C-g>n", "<Right>")
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

-- map('n', 'gx', ":!open <c-r><c-a>")
-- vim.keymap.nnoremap { 'gx', [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]] }
map('n', '<leader>l', ':Format<CR>')
map('n', '<leader>i', ':TSToolsAddMissingImports<CR>')

map('n', '<leader>d', ':TSToolsRemoveUnused<CR>')

-- map('n', '<c-d>', '18j')
-- map('n', '<c-u>', '18k')

-- vim.api.nvim_set_keymap('n', '<CR>', 'ciw', { noremap = true })

map('v', '<leader>p', '"_dP')

-- map('n', '<leader>w', ":w<CR>")

map('n', 'go', '<c-o>')
map('n', 'gi', '<c-i>')

-- map('n', '<c-e>', '<c-d>')
-- map('n', '<c-g>', '<c-u>')

map('n', "yf", 'jgg"+yG<c-o>k')

map('n', "cum", 'jgg"+yG<c-o>k')

map('n', 'U', '<c-r>')

map('v', "<leader>y", '"+y')
map('n', "<leader>y", '"+y')

map('n', "<leader>p", '"+p')
map('v', "<leader>p", '"+p')

map('n', ",.", ':w<CR>')

-- vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", {})


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

vim.keymap.set("i", "<C-BS>", "<C-w>", {})

vim.keymap.set('n', '<Tab>', '<C-W>w')
vim.keymap.set('n', '<S-Tab>', '<C-W>W')

-- vim.keymap.set("n", ";", "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>", { silent = true })

vim.keymap.set("i", "<C-c>", "<ESC>", { silent = true })
