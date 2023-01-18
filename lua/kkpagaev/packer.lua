
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'
	use 'chrisbra/vim-commentary'
	use {
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
            require("colorizer").setup()
        end,
    }
	use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
	use {
		'lewis6991/gitsigns.nvim',
        config = function()
        require('gitsigns').setup()
        end
	}
	use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
	use { 'neoclide/coc.nvim',  branch = 'release' }
	use 'itchyny/lightline.vim'
	use 'fatih/vim-go'
	use 'nvim-tree/nvim-web-devicons'
	use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
	use 'Th3Whit3Wolf/one-nvim'
	use 'hashivim/vim-terraform'
	use {'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}}
-- use 'tribela/vim-transparent'
	use 'voldikss/vim-floaterm'
	use {"akinsho/toggleterm.nvim", tag = '*'}
	use "rebelot/kanagawa.nvim"
end)

