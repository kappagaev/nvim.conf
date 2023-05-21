local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
require('nvim-web-devicons').setup({
    override = {},
    default = true
})
require('telescope').setup {
    -- pickers = {
    -- find_files = {
    -- hidden = true
    -- }
    -- },
    pickers = {
      colorscheme = {
          enable_preview = true
      }
    },
    defaults = {
        path_display = { 'smart' },
        -- file_ignore_patterns = { '.git' },
        mappings = {
            i = {
                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,
                ["<esc>"] = actions.close
            }
        }
    },
    layout_config = {
        horizontal = {
            preview_cutoff = 100,
            preview_width = 0.6
        }
    }
}
vim.keymap.set('n', '<leader><space>', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', builtin.keymaps, {})
vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
vim.keymap.set('n', '<leader>fe', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})

-- vim.keymap.set('n', '<M-p>', builtin.commands, { desc = '[M-p] Find commands' })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>ff', builtin.treesitter, { desc = "Test" })

