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
    cmd = "Copilot",
    event = "BufReadPost",
    opts = {
      toggler = {
        line = 'gcc',
        block = 'gcbc'
      },
    }
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

  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre" -- or "BufWritePost"
      local async = event == "BufWritePost"

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.yamllint,
          null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.code_actions.eslint_d,
          require("typescript.extensions.null-ls.code-actions"),
          null_ls.builtins.diagnostics.erb_lint,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.code_actions.gomodifytags,
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.formatting.stylish_haskell,
          null_ls.builtins.formatting.goimports,
        },
        on_attach = function(client, bufnr)
          -- Enable formatting on sync
          if client.supports_method("textDocument/formatting") then
            local format_on_save = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = format_on_save,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(_client)
                    return _client.name == "null-ls"
                  end
                })
              end,
            })
          end
        end,
      })
    end
  },

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

  {
    "tpope/vim-endwise",
    event = "InsertEnter",
  },

  "onsails/lspkind.nvim",

  {
    "folke/zen-mode.nvim",
    event = "BufRead",
    keys = {
      { ",,", "<cmd>ZenMode<cr>", desc = "ZenMode" },
    },
    opts = {
      window = {
        row = 1,
        width = 1,
        height = 1,
        options = {
          signcolumn = "yes",    -- disable signcolumn
          number = true,         -- disable number column
          relativenumber = true, -- disable relative numbers
          cursorline = true,     -- disable cursorline
          cursorcolumn = false,  -- disable cursor column
          foldcolumn = "0",      -- disable fold column
          list = true,           -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,   -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          laststatus = 0
        },
        tmux = { enabled = false },
        gitsigns = { enabled = false },
      },
      on_open = function(win)
        vim.cmd("ScrollbarHide")
      end,
      on_close = function(win)
        vim.cmd("ScrollbarShow")
      end,
    }
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
    event = "InsertEnter",
    opts = {
    },
    -- config = function()
    --   require('nvim-autopairs').setup()
    -- end
  },

  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    config = {}
  },

  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  "jlcrochet/vim-crystal",

  "suketa/nvim-dap-ruby",

  'mfussenegger/nvim-dap-python',

  "ThePrimeagen/harpoon",

  "ntpeters/vim-better-whitespace",

  "rcarriga/cmp-dap",

  "jose-elias-alvarez/typescript.nvim",

  'nvim-treesitter/nvim-treesitter-context',

  "tpope/vim-fugitive",

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
