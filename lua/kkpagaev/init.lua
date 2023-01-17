require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')

local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>q', '<Cmd>BufferClose<CR>')
map('n', '<leader><Tab>', '<Cmd>BufferNext<CR>')
map('n', '<leader><Shift><Tab>', '<Cmd>BufferPrevious<CR>')
map('n', '<leader>g', '<Cmd>LazyGit<CR>')
map('n', '<leader>t', '<Cmd>FloatermToggle<CR>')

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(31, 'FileTree')
    end
  end
})
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
    mappings = {
      list = {

      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require('gitsigns').setup()
vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local keyset = vim.keymap.set
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--keyset("i", "<c-space>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<c-space>" : coc#refresh()', opts)
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

