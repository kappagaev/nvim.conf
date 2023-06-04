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
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
  },
  "lewis6991/hover.nvim",

  'nvim-tree/nvim-web-devicons',

  -- 'mfussenegger/nvim-dap',

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local status_ok, null_ls = pcall(require, "null-ls")
      if not status_ok then
        return
      end

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
  -- MARK

  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {}

  },

  "folke/trouble.nvim",
  {

    "folke/todo-comments.nvim",
  },

  {
    "tpope/vim-endwise",
    event = "InsertEnter",
  },

  "onsails/lspkind.nvim",

  -- {
  --   "folke/zen-mode.nvim",
  --   event = "BufRead",
  --   keys = {
  --     { ",,", "<cmd>ZenMode<cr>", desc = "ZenMode" },
  --   },
  --   opts = {
  --     window = {
  --       row = 1,
  --       width = 1,
  --       height = 1,
  --       options = {
  --         signcolumn = "yes",    -- disable signcolumn
  --         number = true,         -- disable number column
  --         relativenumber = true, -- disable relative numbers
  --         cursorline = true,     -- disable cursorline
  --         cursorcolumn = false,  -- disable cursor column
  --         foldcolumn = "0",      -- disable fold column
  --         list = true,           -- disable whitespace characters
  --       },
  --     },
  --     plugins = {
  --       options = {
  --         enabled = true,
  --         ruler = false,   -- disables the ruler text in the cmd line area
  --         showcmd = false, -- disables the command in the last line of the screen
  --         laststatus = 0
  --       },
  --       tmux = { enabled = false },
  --       gitsigns = { enabled = false },
  --     },
  --     on_open = function(win)
  --       vim.cmd("ScrollbarHide")
  --     end,
  --     on_close = function(win)
  --       vim.cmd("ScrollbarShow")
  --     end,
  --   }
  -- },

  {
    'nacro90/numb.nvim',
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
    },
  },

  {
    "kylechui/nvim-surround",
    event = "InsertEnter",
    opts = {}
  },


  "ntpeters/vim-better-whitespace",

  'nvim-treesitter/nvim-treesitter-context',
  {
    "tpope/vim-fugitive",
    lazy = true,
    keys = {
      { "<leader>g", ":Git<cr>",         { silent = true } },
      { "gd",        ":Gdiffsplit<cr>",  { silent = true } },
      { "gD",        ":Gdiffsplit!<CR>", { silent = true } },
    }
  },
  {
    import = "plugins"
  }
}

require("lazy").setup(plugins, {
})
