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
  'numToStr/Comment.nvim',

  "norcalli/nvim-colorizer.lua",
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly'                  -- optional, updated every week. (see issue #1193)
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  {
    -- LSP Configuration & Plugins
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

  { 'nvim-treesitter/nvim-treesitter' },

  {
    "rebelot/kanagawa.nvim",
    commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  },

  'mfussenegger/nvim-dap',

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" }
  },

  'jose-elias-alvarez/null-ls.nvim',

  "petertriho/nvim-scrollbar",

  "ray-x/lsp_signature.nvim",

  "folke/trouble.nvim",

  "folke/todo-comments.nvim",

  "tpope/vim-endwise",

  "onsails/lspkind.nvim",

  {
    "folke/zen-mode.nvim",
    config = function()
    end
  },

  'nacro90/numb.nvim',

  'hrsh7th/cmp-buffer',

  'windwp/nvim-autopairs',

  {
    "kylechui/nvim-surround",
  },

  { "mxsdev/nvim-dap-vscode-js",       dependencies = { "mfussenegger/nvim-dap" } },
  "jlcrochet/vim-crystal",

  {
    'notjedi/nvim-rooter.lua',
    config = function()
    end
  },

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
}

require("lazy").setup(plugins, {

})
