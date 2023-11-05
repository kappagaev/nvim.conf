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
    lazy = true,
    opts = {},
    keys = {
      { "gcc",  mode = "n" },
      { "gcip", mode = "n" },
      { "gc",   mode = "v" },
      { "gbc",  mode = "n" },
      { "gb",   mode = "v" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          RGB = true,          -- #RGB hex codes
          RRGGBB = true,       -- #RRGGBB hex codes
          names = true,        -- "Name" codes like Blue or blue
          RRGGBBAA = false,    -- #RRGGBBAA hex codes
          AARRGGBB = false,    -- 0xAARRGGBB hex codes
          rgb_fn = false,      -- CSS rgb() and rgba() functions
          hsl_fn = false,      -- CSS hsl() and hsla() functions
          css = false,         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false,      -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "foreground", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                                 -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          -- example use: cmp_menu, cmp_docs
          always_update = false
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    ft = { "gitcommit", "diff" },
    keys = {
      { "<leader>b", "<CMD>Gitsigns blame_line<CR>" }
    },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = {
      trouble = false
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    lazy = true,
    config = function()
      require("plugins.config.formatter")
    end
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- 'jmbuhr/otter.nvim',
      -- "quarto-dev/quarto-nvim",
      -- 'nvim-treesitter/nvim-treesitter',
      -- "mhartington/formatter.nvim",
      "pmizio/typescript-tools.nvim",
      "lewis6991/hover.nvim",
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "ray-x/lsp_signature.nvim",
      {
        'j-hui/fidget.nvim',
        tag = "legacy"
      }
    },
    lazy = false,
    -- init = function()
    --   lazy_load "nvim-lspconfig"
    -- end,
    config = function()
      require("plugins.config.lsp")
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
          local luasnip = require 'luasnip'
          local types = require 'luasnip.util.types'

          luasnip.setup {
            { history = true, updateevents = "TextChanged,TextChangedI" },
            -- Display a cursor-like placeholder in unvisited nodes
            -- of the snippet.
            -- ext_opts = {
            --   [types.insertNode] = {
            --     unvisited = {
            --       virt_text = { { '|', 'Conceal' } },
            --       virt_text_pos = 'inline',
            --     },
            --   },
            --   -- This is needed because LuaSnip differentiates between $0 and other
            --   -- placeholders (exitNode and insertNode). So this will highlight the last
            --   -- jump node.
            --   [types.exitNode] = {
            --     unvisited = {
            --       virt_text = { { '|', 'Conceal' } },
            --       virt_text_pos = 'inline',
            --     },
            --   },
            -- },
          }

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
      'hrsh7th/cmp-nvim-lsp',
      "saadparwaiz1/cmp_luasnip",
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require("plugins.config.cmp")
    end
  },
  {
    "lewis6991/hover.nvim",
    lazy = true,
    opts = {
      init = function()
        require("hover.providers.lsp")
      end,
      preview_opts = {
        border = nil
      },
      preview_window = false,
      title = true
    }
  },
  {
    'mfussenegger/nvim-dap',
    keys = {
      "<C-g>",
      "<C-c>",
      "<C-r>",
      "<C-l>",
    },
    dependencies = {
      "rcarriga/cmp-dap",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {}
      },
      { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
      -- "jlcrochet/vim-crystal",
    },
    lazy = true,
    config = function()
      require("plugins.config.dap")
    end
  },
  {
    "petertriho/nvim-scrollbar",
    opts = {}
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    keys = {
      {
        "<leader>t", "<CMD>TroubleToggle<CR>"
      }
    },
    opts = {},
  },
  {
    'nacro90/numb.nvim',
    lazy = false,
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = "InsertEnter",
    opts = {
    },
  },
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = false,
    opts = {}
  },
  -- 'mfussenegger/nvim-dap-python',
  {
    dir = "lua/alternate",
    keys = {
      ",t",
      ",T",
      ",h",
      ",m",
      ",c",
      ",e"
    },
    config = function()
      require("alternate")
    end
  },
  -- "vimpostor/vim-tpipeline",
  {
    dir = "lua/test",
    keys = {
      ",h"
    },
    dependencies = {
      'mfussenegger/nvim-dap'
    },
    config = function()
      require("test")
    end
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end
  },

  {
    "axelvc/template-string.nvim",
    config = function()
      require('template-string').setup({
        filetypes = { 'vue', 'astro', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }, -- filetypes where the plugin is active
        jsx_brackets = true,                                                                              -- must add brackets to jsx attributes
        remove_template_string = false,                                                                   -- remove backticks when there are no template string
        restore_quotes = {
          -- quotes used when "remove_template_string" option is enabled
          normal = [[']],
          jsx = [["]],
        },
      })
    end
  },
  -- {
  --   "vimwiki/vimwiki",
  --   event = "BufEnter *.md",
  -- },
  -- "andythigpen/nvim-coverage",
  --
  "tpope/vim-rsi",
  "leoluz/nvim-dap-go",
  "Exafunction/codeium.vim",
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.config.lint")
    end
  },
  "windwp/nvim-ts-autotag",
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({
        magic_window = false,
        preview = {
          border = 'none',
          win_height = 999,
          show_scroll_bar = false,
          winblend = 0
        }
      })
    end
  },
  -- lazy.nvim:
  {
    "mbbill/undotree",
    lazy = false,
    config = function()
      vim.keymap.set("n", ",u", "<CMD>UndotreeToggle<CR>", {
        silent = true
      })
    end
  },
  {
    import = "plugins"
  }
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = false
  }
})
