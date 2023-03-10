local g = vim.g

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

g.mapleader = " "
g.maplocalleader = " "

map('n', "<leader>", "")
-- map('n', '<C-j>', '5j')

-- map('n', '<c-k>', '5k')
-- map('n', '<c-l>', '5l')
-- map('n', '<c-h>', '5h')
-- map('n', '<c-g>', 'gcc')
-- map('n', '<leader>w', ':update<CR>')
map('i', 'jj', '<Esc>')
map('i', 'JJ', '<Esc>')
map('i', 'оо', '<Esc>')
map('i', 'ОО', '<Esc>')
-- map('n', 'gx', ":!open <c-r><c-a>")
-- vim.keymap.nnoremap { 'gx', [[:execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]] }
map('n', '<leader>l', ':Format<CR>')

map('n', '<c-d>', '18j')
map('n', '<c-u>', '18k')

map('v', '<leader>p', '"_dP')

-- map('n', '<leader>w', ":w<CR>")

map('n', 'gb', '<c-o>')

map('n', "yf", 'ggyG<c-o>')

map('n', 'U', '<c-r>')

-- _G.main_func = function()
-- vim.cmd("VimwikiToggleListItem")
-- vim.go.operatorfunc = "v:lua.main_func"
-- return "g@l"
-- end


-- vim.keymap.set("n", "glt", main_func, { expr = true, silent = true})
vim.keymap.set("n", "glt", ":VimwikiToggleListItem<CR>", {  silent = true})
-- vim.keymap.set('i','<C-]>', '<esc>f\\|ni', { silent = true })
--



map("n", "й", "q")
map("n", "ц", "w")
map("n", "у", "e")
map("n", "к", "r")
map("n", "е", "t")
map("n", "н", "y")
map("n", "г", "u")
map("n", "ш", "i")
map("n", "щ", "o")
map("n", "з", "p")
map("n", "х", "[")
map("n", "ї", "]")
map("n", "ф", "a")
map("n", "і", "s")
map("n", "в", "d")
map("n", "а", "f")
map("n", "п", "g")
map("n", "р", "h")
map("n", "о", "j")
map("n", "л", "k")
map("n", "д", "l")
map("n", "ж", ";")
map("n", "є", "'")
map("n", "я", "z")
map("n", "ч", "x")
map("n", "с", "c")
map("n", "м", "v")
map("n", "и", "b")
map("n", "т", "n")
map("n", "ь", "m")
map("n", "б", ",")
map("n", "ю", ".")
map("n", "Й", "Q")
map("n", "Ц", "W")
map("n", "У", "E")
map("n", "К", "R")
map("n", "Е", "T")
map("n", "Н", "Y")
map("n", "Г", "U")
map("n", "Ш", "I")
map("n", "Щ", "O")
map("n", "З", "P")
map("n", "Х", "{")
map("n", "Ї", "}")
map("n", "Ф", "A")
map("n", "І", "S")
map("n", "В", "D")
map("n", "А", "F")
map("n", "П", "G")
map("n", "Р", "H")
map("n", "О", "J")
map("n", "Л", "K")
map("n", "Д", "L")
map("n", "Ж", ":")
map("n", "Э", '"')
map("n", "Я", "Z")
map("n", "Ч", "X")
map("n", "С", "C")
map("n", "М", "V")
map("n", "И", "B")
map("n", "Т", "N")
map("n", "Ь", "M")
map("n", "Б", "<")
map("n", "Ю", ">")
