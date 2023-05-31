local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
map('v', "j", "h")
map('v', "h", "j")

map('v', "t", "k")
map('v', "k", "t")

map('n', "j", "h")
map('n', "h", "j")

map('n', "t", "k")
map('n', "k", "t")
-- map('n', '<C-j>', '5j')

-- map('n', '<c-k>', '5k')
-- map('n', '<c-l>', '5l')
-- map('n', '<c-h>', '5h')
-- map('n', '<c-g>', 'gcc')
-- map('n', '<leader>w', ':update<CR>')
map('i', 'hh', '<Esc>')
map('i', 'HH', '<Esc>')
map("n", "YY", "va{Vy")

vim.api.nvim_set_keymap('n', ',', '<C-w>', { noremap = true })
vim.api.nvim_set_keymap('n', "'", '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', ",h", '<C-w>w', { noremap = true })
vim.api.nvim_set_keymap('n', ",d", '<C-w>q', { noremap = true })

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

vim.keymap.set("n", "<C-f>", "<cmd>silent !t<CR>")


-- map("n", "й", "q")
-- map("n", "ц", "w")
-- map("n", "у", "e")
-- map("n", "к", "r")
-- map("n", "е", "t")
-- map("n", "н", "y")
-- map("n", "г", "u")
-- map("n", "ш", "i")
-- map("n", "щ", "o")
-- map("n", "з", "p")
-- map("n", "х", "[")
-- map("n", "ї", "]")
-- map("n", "ф", "a")
-- map("n", "і", "s")
-- map("n", "в", "d")
-- map("n", "а", "f")
-- map("n", "п", "g")
-- map("n", "р", "h")
-- map("n", "о", "j")
-- map("n", "л", "k")
-- map("n", "д", "l")
-- map("n", "ж", ";")
-- map("n", "є", "'")
-- map("n", "я", "z")
-- map("n", "ч", "x")
-- map("n", "с", "c")
-- map("n", "м", "v")
-- map("n", "и", "b")
-- map("n", "т", "n")
-- map("n", "ь", "m")
-- map("n", "б", ",")
-- map("n", "ю", ".")
-- map("n", "Й", "Q")
-- map("n", "Ц", "W")
-- map("n", "У", "E")
-- map("n", "К", "R")
-- map("n", "Е", "T")
-- map("n", "Н", "Y")
-- map("n", "Г", "U")
-- map("n", "Ш", "I")
-- map("n", "Щ", "O")
-- map("n", "З", "P")
-- map("n", "Х", "{")
-- map("n", "Ї", "}")
-- map("n", "Ф", "A")
-- map("n", "І", "S")
-- map("n", "В", "D")
-- map("n", "А", "F")
-- map("n", "П", "G")
-- map("n", "Р", "H")
-- map("n", "О", "J")
-- map("n", "Л", "K")
-- map("n", "Д", "L")
-- map("n", "Ж", ":")
-- map("n", "Э", '"')
-- map("n", "Я", "Z")
-- map("n", "Ч", "X")
-- map("n", "С", "C")
-- map("n", "М", "V")
-- map("n", "И", "B")
-- map("n", "Т", "N")
-- map("n", "Ь", "M")
-- map("n", "Б", "<")
-- map("n", "Ю", ">")
