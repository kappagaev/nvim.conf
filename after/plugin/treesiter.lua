require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "yaml", "go", "tsx", "lua", "rust", "json", "graphql", "regex", "vim", "ruby" },

	sync_install = false,
	auto_install = true,
-- ignore_install = { "javascript" },


	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<c-backspace>",
		},
	},
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = {}
	},
	autotag = {
		enable = true
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil
	},
-- markid = { enable = true }
}
