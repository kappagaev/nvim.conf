require("zen-mode").setup {
		window = {
				width = 1
		},
		plugins = {
				options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
				},
				barbecue = { enabled = false },
				twilight = { enabled = true },
        tmux = { enabled = true}
		},

				on_open = function(win)
					vim.cmd("Barbecue hide")
				end,
				on_close = function(win)
					vim.cmd("Barbecue show")
				end,
}

require("twilight").setup {
		context = 18,
		expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
				"function",
				"method",
		},
}

vim.keymap.set('n', '<leader>j', function()

	vim.cmd("ZenMode")
end)
