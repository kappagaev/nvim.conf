local builtin = require('telescope.builtin')

local actions = require('telescope.actions')
require('nvim-web-devicons').setup({
	override = {},
	default = true
})
require('telescope').setup {
	defaults = {
		path_display = { 'smart' },
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
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.	
end, { desc = '[/] Fuzzily search in current buffer]' })
