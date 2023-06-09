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
  {
    -- snippet plugin
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)

      -- require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets/snipmate" }
      local loader = require("luasnip/loaders/from_vscode")
      loader.lazy_load()

      -- load snippets from path/of/your/nvim/config/my-cool-snippets
      loader.lazy_load({ paths = { "./snippets" } })

      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
              require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
              and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  "saadparwaiz1/cmp_luasnip",
  {
    "petertriho/nvim-scrollbar",
    opts = {}

  },

  "ray-x/lsp_signature.nvim",

  "folke/trouble.nvim",

  {

    "folke/todo-comments.nvim",
  },

  {
    "tpope/vim-endwise",
  },

  "onsails/lspkind.nvim",

  {
    "folke/zen-mode.nvim",
    event = "BufRead",
    keys = {
      { "&", "<cmd>ZenMode<cr>", desc = "ZenMode" },
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
          cursorline = false,    -- disable cursorline
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
    opts = {}
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
    opts = {}
  },

  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  -- "jlcrochet/vim-crystal",

  "suketa/nvim-dap-ruby",

  'mfussenegger/nvim-dap-python',

  "ThePrimeagen/harpoon",

  "ntpeters/vim-better-whitespace",

  "rcarriga/cmp-dap",

  "jose-elias-alvarez/typescript.nvim",

  'nvim-treesitter/nvim-treesitter-context',

  "tpope/vim-fugitive",
  {
    'tomasky/bookmarks.nvim',
    event = "VimEnter",
    config = function()
      require('bookmarks').setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        sign_priority=200,
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n", "m", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", ",i", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", ",c", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", ",n", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", ",,", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", ";", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", ",p", bm.bookmark_prev) -- jump to previous mark in local buffer
          -- map("n", ",h", bm.bookmark_list) -- show marked file list in quickfix window
        end
      }
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text"
  },
  "andythigpen/nvim-coverage",
  {
    import = "plugins"
  }
}

require("lazy").setup(plugins, {
})
