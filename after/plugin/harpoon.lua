-- vim.keymap.set('n', ',', function()
-- vim.cmd("NvimTreeClose")
-- require("harpoon.ui").nav_next()
-- end)

require("harpoon").setup({
-- global_settings = {
-- mark_branch = true,
-- },
})
vim.keymap.set('n', '<leader>h', function()
  require("telescope").extensions.harpoon.marks({
    on_complete = { function() vim.cmd "stopinsert" end }
  })
  -- require("harpoon.ui").toggle_quick_menu()
end)


-- vim.keymap.set('n', 'm', function()
-- require("harpoon.mark").add_file()
-- end)

-- vim.keymap.set('n', '`', function()
-- require("harpoon.ui").toggle_quick_menu()
-- end)
