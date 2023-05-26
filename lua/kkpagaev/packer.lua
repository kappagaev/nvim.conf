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

  use 'numToStr/Comment.nvim'

  use "norcalli/nvim-colorizer.lua"
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'                  -- optional, updated every week. (see issue #1193)
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
    },
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp' },
  }
  use "lewis6991/hover.nvim"

  use 'nvim-tree/nvim-web-devicons'

  use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }

  use {
    "rebelot/kanagawa.nvim",
    commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  }

  use 'mfussenegger/nvim-dap'

  -- use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  use('jose-elias-alvarez/null-ls.nvim')

  use("petertriho/nvim-scrollbar")

  use("ray-x/lsp_signature.nvim")

  use("folke/trouble.nvim")

  use("folke/todo-comments.nvim")

  use("tpope/vim-endwise")

  use("onsails/lspkind.nvim")

  use {
    "folke/zen-mode.nvim",
    config = function()
    end
  }

  use 'nacro90/numb.nvim'

  use "dstein64/vim-startuptime"

  use "jose-elias-alvarez/typescript.nvim"

  use 'hrsh7th/cmp-buffer'

  use 'windwp/nvim-autopairs'

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
    end
  })
  use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
  -- use "vimwiki/vimwiki"
  use "jlcrochet/vim-crystal"

  use {
    'notjedi/nvim-rooter.lua',
    config = function()
    end
  }

  use "suketa/nvim-dap-ruby"

  use 'mfussenegger/nvim-dap-python'

  use "ThePrimeagen/harpoon"

  use "ntpeters/vim-better-whitespace"

  use "rcarriga/cmp-dap"

  use "jose-elias-alvarez/typescript.nvim"

  -- use "ThePrimeagen/vim-be-good"

  use 'nvim-treesitter/nvim-treesitter-context'

  -- use "justinmk/vim-sneak"

  use "nvim-treesitter/playground"

  use "tpope/vim-fugitive"

  use "Eandrju/cellular-automaton.nvim"

  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- install jsregexp (optional!:).
    -- run = "make install_jsregexp"
  })
  use "rafamadriz/friendly-snippets"

end)
