local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        toggler = {
          line = 'gcc',
          block = 'gcbc'
        },
      })
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      'j-hui/fidget.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  },
  "lewis6991/hover.nvim",

  'nvim-tree/nvim-web-devicons',

  {
  },

  'mfussenegger/nvim-dap',

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" }
  },

  'jose-elias-alvarez/null-ls.nvim',

  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },

  "ray-x/lsp_signature.nvim",

  "folke/trouble.nvim",

  {

    "folke/todo-comments.nvim",
  },

  "tpope/vim-endwise",

  "onsails/lspkind.nvim",

  {
    "folke/zen-mode.nvim",
    config = function()
    end
  },

  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup()
    end
  },

  'hrsh7th/cmp-buffer',

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  { "mxsdev/nvim-dap-vscode-js",      dependencies = { "mfussenegger/nvim-dap" } },
  "jlcrochet/vim-crystal",

  "suketa/nvim-dap-ruby",

  'mfussenegger/nvim-dap-python',

  "ThePrimeagen/harpoon",

  "ntpeters/vim-better-whitespace",

  "rcarriga/cmp-dap",

  "jose-elias-alvarez/typescript.nvim",

  'nvim-treesitter/nvim-treesitter-context',

  "nvim-treesitter/playground",

  "tpope/vim-fugitive",

  "Eandrju/cellular-automaton.nvim",

  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "theHamsta/nvim-dap-virtual-text"
  },
  "andythigpen/nvim-coverage",
  {
  },
  {
    import = "plugins"
  }
}

require("lazy").setup(plugins, {
})
