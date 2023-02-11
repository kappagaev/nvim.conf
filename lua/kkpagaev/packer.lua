vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
      -- use 'vim-airline/vim-airline'
      -- use 'vim-airline/vim-airline-themes'
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
          requires = { { 'nvim-lua/plenary.nvim' } }
      }
      use { -- LSP Configuration & Plugins
          'neovim/nvim-lspconfig',
          requires = {
              -- Automatically install LSPs to stdpath for neovim
              'williamboman/mason.nvim',
              'williamboman/mason-lspconfig.nvim',

              -- Useful status updates for LSP
              'j-hui/fidget.nvim',

              -- Additional lua configuration, makes nvim stuff amazing
              'folke/neodev.nvim',
          },
      }

      use { -- Autocompletion
          'hrsh7th/nvim-cmp',
          requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
      }


      use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
      -- use { 'neoclide/coc.nvim',  branch = 'release' }
      -- use 'itchyny/lightline.vim'
      use 'fatih/vim-go'
      use 'nvim-tree/nvim-web-devicons'
      -- use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons' }
      use 'hashivim/vim-terraform'
      use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
-- use 'tribela/vim-transparent'
      use 'voldikss/vim-floaterm'
      use "rebelot/kanagawa.nvim"
      use "ethanholz/nvim-lastplace"

      use 'mfussenegger/nvim-dap'
      use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

      use 'leoluz/nvim-dap-go'
      use { 'Weissle/persistent-breakpoints.nvim' }

      use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

      use('jose-elias-alvarez/null-ls.nvim')

      use("petertriho/nvim-scrollbar")

      use("ray-x/lsp_signature.nvim")

      use("folke/trouble.nvim")

      use("folke/todo-comments.nvim")

      use("ThePrimeagen/vim-be-good")

      use("ThePrimeagen/harpoon")

      use("jiangmiao/auto-pairs")

      use("tpope/vim-endwise")

      use("rafamadriz/friendly-snippets")

      use("onsails/lspkind.nvim")

      use("mattn/emmet-vim")

      use({
          'weilbith/nvim-code-action-menu',
          cmd = 'CodeActionMenu',
      })

      use {
          'kosayoda/nvim-lightbulb',
          requires = 'antoinemadec/FixCursorHold.nvim',
      }
      use({
          "utilyre/barbecue.nvim",
          requires = {
              "SmiteshP/nvim-navic",
              "nvim-tree/nvim-web-devicons", -- optional dependency
          },
      })
      use {
          "folke/zen-mode.nvim",
          config = function()
          end
      }
      -- Lua
      use {
          "folke/twilight.nvim",
          config = function()
            require("twilight").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
          end
      }
      use {
          'filipdutescu/renamer.nvim',
          branch = 'master',
          requires = { { 'nvim-lua/plenary.nvim' } }
      }
      use 'nacro90/numb.nvim'
      use 'booperlv/nvim-gomove'
      use {
          "AckslD/nvim-neoclip.lua",
          requires = {
              -- you'll need at least one of these
              { 'nvim-telescope/telescope.nvim' },
              -- {'ibhagwan/fzf-lua'},
          },
          config = function()
          end,
      }
      -- use 'echasnovski/mini.starter'
      -- use {
      -- 'glepnir/dashboard-nvim',
      -- event = 'VimEnter',
      -- config = function()
      -- require('dashboard').setup()
      -- end,
      -- requires = {'nvim-tree/nvim-web-devicons'}
      -- }
      use { 'ray-x/starry.nvim', setup = function()
        vim.g.starry_italic_comments = true
      end }
use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}
  use "dstein64/vim-startuptime"

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
end}
    end)
