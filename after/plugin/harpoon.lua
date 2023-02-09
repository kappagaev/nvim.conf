vim.keymap.set('n', ',', function()
	require("harpoon.ui").nav_next()
end)

require("harpoon").setup({
	global_settings = {
		mark_branch = true,
	},
})
vim.keymap.set('n', 'J', function()
	require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set('n', 'M', function()
	require("harpoon.mark").add_file()
end)

