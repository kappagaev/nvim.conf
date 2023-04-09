vim.cmd.packadd('packer.nvim')

local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'chrisbra/vim-commentary'
  use {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    config = function()
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
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'j-hui/fidget.nvim',

      'folke/neodev.nvim',
    },
  }

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  use "lewis6991/hover.nvim"

  -- use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  use 'nvim-tree/nvim-web-devicons'
-- use 'hashivim/vim-terraform'
  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }

  use 'voldikss/vim-floaterm'
  use {
    "rebelot/kanagawa.nvim",
commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  }
-- use "ethanholz/nvim-lastplace"

  use 'mfussenegger/nvim-dap'

  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

-- use 'leoluz/nvim-dap-go'

-- use { 'Weissle/persistent-breakpoints.nvim' }

-- use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

  use('jose-elias-alvarez/null-ls.nvim')

  use("petertriho/nvim-scrollbar")

  use("ray-x/lsp_signature.nvim")

  use("folke/trouble.nvim")

  use("folke/todo-comments.nvim")

-- use("ThePrimeagen/vim-be-good")

  use("tpope/vim-endwise")

  use("onsails/lspkind.nvim")

-- use({
-- "utilyre/barbecue.nvim",
-- requires = {
-- "SmiteshP/nvim-navic",
-- "nvim-tree/nvim-web-devicons", -- optional dependency
-- },
-- })

  use {
    "folke/zen-mode.nvim",
    config = function()
    end
  }

  use 'nacro90/numb.nvim'
  use 'booperlv/nvim-gomove'

-- use {
-- "AckslD/nvim-neoclip.lua",
-- requires = {
-- { 'nvim-telescope/telescope.nvim' },
-- },
-- config = function()
-- end,
-- }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use "dstein64/vim-startuptime"

-- use 'tpope/vim-rails'
-- use 'suketa/nvim-dap-ruby'
-- use "vim-test/vim-test"
    use "jose-elias-alvarez/typescript.nvim"
-- use 'David-Kunz/markid'
-- use 'gorbit99/codewindow.nvim'

  use 'hrsh7th/cmp-buffer'

-- use 'hrsh7th/vim-vsnip'
-- use 'hrsh7th/vim-vsnip-integ'

-- use 'ray-x/go.nvim'
-- use 'ray-x/guihua.lua' -- reco
  use 'windwp/nvim-autopairs'

  -- colors
  use "pineapplegiant/spaceduck"
  use { "catppuccin/nvim", as = "catppuccin" }

  -- use { 'justinhj/battery.nvim', requires = { { 'kyazdani42/nvim-web-devicons' }, { 'nvim-lua/plenary.nvim' } } }

-- use({
-- "aserowy/tmux.nvim",
-- })

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
    end
  })
  use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  use "vimwiki/vimwiki"
-- use "folke/which-key.nvim"
  -- use "vim-crystal/vim-crystal"

  use "jlcrochet/vim-crystal"
-- use({
-- "glepnir/lspsaga.nvim",
-- branch = "main",
-- config = function()
-- end,
-- requires = {
-- { "nvim-tree/nvim-web-devicons" },
-- { "nvim-treesitter/nvim-treesitter" }
-- }
-- })
  use {
    'notjedi/nvim-rooter.lua',
    config = function()
    end
  }
-- use "justinmk/vim-sneak"

use 'mfussenegger/nvim-dap-python'

  use "ThePrimeagen/harpoon"

-- use "mrjones2014/nvim-ts-rainbow"

-- use "stephendolan/neovim-lucky"

  use "ntpeters/vim-better-whitespace"

  use "rcarriga/cmp-dap"
end)
