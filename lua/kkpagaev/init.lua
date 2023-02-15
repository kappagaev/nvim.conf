require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')
require('kkpagaev.autocmd')

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', 'Q', '<Cmd>bd<CR>')
map('n', '<leader>Q', '<Cmd>bd!<CR>')

require("luasnip.loaders.from_vscode").lazy_load()

require("hover").setup {
    init = function()
      -- Require providers
      require("hover.providers.lsp")
      -- require('hover.providers.gh')
      -- require('hover.providers.gh_user')
      -- require('hover.providers.jira')
      -- require('hover.providers.man')
      -- require('hover.providers.dictionary')
    end,
    preview_opts = {
        border = nil
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true
}

  -- Setup keymaps
require("barbecue").setup({
 show_modified = true,
})
require 'luasnip'.filetype_extend("ruby", { "rails" })
require 'luasnip'.filetype_extend("go", { "go" })

map('n', '<leader><Shift><Tab>', '<Cmd>BufferLineCyclePrev<CR>')
require 'nvim-web-devicons'.setup {
		override = {
				zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh"
				}
		},
		color_icons = true,
		default = true,
}
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("scrollbar").setup()

require("renamer").setup({})

local codewindow = require('codewindow')
    codewindow.setup()
    codewindow.apply_default_keybinds()

require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}
require('packer').use({
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
})
require('gitsigns').setup()

-- vim.api.nvim_create_autocmd("FileType", {
-- pattern = "dap-repl",
-- callback = function(args)
-- vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
-- end,
-- })

require('nvim-autopairs').setup()


require('numb').setup()
require'nvim-lastplace'.setup{}

local battery = require("battery")
battery.setup({
	update_rate_seconds = 30,           -- Number of seconds between checking battery status
	show_status_when_no_battery = true, -- Don't show any icon or text when no battery found (desktop for example)
	show_plugged_icon = false,           -- If true show a cable icon alongside the battery icon when plugged in
	show_unplugged_icon = false,         -- When true show a diconnected cable icon when not plugged in
	show_percent = true,                -- Whether or not to show the percent charge remaining in digits
    vertical_icons = true,              -- When true icons are vertical, otherwise shows horizontal battery icon
    multiple_battery_selection = 1,     -- Which battery to choose when multiple found. "max" or "maximum", "min" or "minimum" or a number to pick the nth battery found (currently linux acpi only)
})
-- require('mini.starter').setup()

