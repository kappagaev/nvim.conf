require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.packer')

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<leader>e', ':NvimTreeToggle<CR>')
map('n', '<leader>q', '<Cmd>bd<CR>')
map('n', '<leader><Tab>', '<Cmd>BufferLineCycleNext<CR>')
map('n', '<leader><Shift><Tab>', '<Cmd>BufferLineCyclePrev<CR>')
require 'nvim-web-devicons'.setup {
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		}
	};
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true;
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true;
}

vim.opt.termguicolors = true
require("bufferline").setup {}
-- vim.api.nvim_create_autocmd('BufWinEnter', {
-- pattern = '*',
-- callback = function()
-- if vim.bo.filetype == 'NvimTree' then
-- require 'bufferline.api'.set_offset(31, 'FileTree')
-- end
-- end
-- })

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups


require("scrollbar").setup()

-- OR setup with some options
require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "h", action = "close_node" },
				{ key = "l", action = "preview" },
			},
		},
	},
	-- actions = {
	-- open_file = { quit_on_open = true },
	-- },
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		debounce_delay = 50,
		icons = {
			hint = 'H',
			info = 'I',
			warning = 'W',
			error = 'E'
		}
	}
})

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
	-- char = '*',
	char = '┊',
	show_trailing_blankline_indent = false,
}

-- require("galaxyline.themes.eviline")

require('gitsigns').setup()

require("lsp_signature").setup()

require("trouble").setup()
-- vim.api.nvim_create_autocmd('BufWinLeave', {
-- pattern = '*',
-- callback = function()
-- if vim.fn.expand('<afile>'):match('NvimTree') then
-- require 'bufferline.api'.set_offset(0)
-- end
-- end
-- })

-- Autocomplete
-- function _G.check_back_space()
-- local col = vim.fn.col('.') - 1
-- return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end

-- local keyset = vim.keymap.set
-- local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
--keyset("i", "<c-space>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<c-space>" : coc#refresh()', opts)
-- keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })
