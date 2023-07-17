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

local function lazy_load(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "null-ls" then
              vim.cmd "silent! do FileType"
            end
            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end
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
    lazy = false,
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          RGB = true,        -- #RGB hex codes
          RRGGBB = true,     -- #RRGGBB hex codes
          names = true,      -- "Name" codes like Blue or blue
          RRGGBBAA = false,  -- #RRGGBBAA hex codes
          AARRGGBB = false,  -- 0xAARRGGBB hex codes
          rgb_fn = false,    -- CSS rgb() and rgba() functions
          hsl_fn = false,    -- CSS hsl() and hsla() functions
          css = false,       -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false,    -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "foreground", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true,                              -- Enable tailwind colors
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
    'neovim/nvim-lspconfig',
    dependencies = {
      "mhartington/formatter.nvim",
      "pmizio/typescript-tools.nvim",
      "jose-elias-alvarez/typescript.nvim",
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
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    commands = {
      "Octo"
    },
    config = function()
      require("plugins.config.octo")
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

      "suketa/nvim-dap-ruby",
      {
        "rcarriga/nvim-dap-ui",
        lazy = true,
        opts = {
          layouts = {
            {
              elements = {
                -- "scopes",
                -- "watches",
              },
              size = 30, -- 40 columns
              position = "right",
            },
            {
              elements = {
                "repl",
              },
              size = 0.50, -- 20% of total lines
              position = "bottom",
            },
          },
        }
      },
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

  -- {
  --   "tpope/vim-endwise",
  -- },


  -- {
  --   "folke/zen-mode.nvim",
  --   event = "BufRead",
  --   keys = {
  --     { "&", "<cmd>ZenMode<cr>", desc = "ZenMode" },
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
  --         cursorline = false,    -- disable cursorline
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
    lazy = false,
    opts = {}
  },


  {
    'windwp/nvim-autopairs',
    -- event = "InsertEnter",
    lazy = true,
    event = "InsertEnter",
    opts = {
    },
    -- config = function()
    --   require('nvim-autopairs').setup()
    -- end
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   dependencies = {
  --     "arturgoms/moonbow.nvim",
  --     "vimpostor/vim-tpipeline",
  --   },
  --   config = function()
  --     require("plugins.config.lualine")
  --   end
  -- },
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = false,
    opts = {}
  },


  -- 'mfussenegger/nvim-dap-python',
  -- "ntpeters/vim-better-whitespace",



  -- {
  --   'tomasky/bookmarks.nvim',
  --   event = "VimEnter",
  --   config = function()
  --     require('bookmarks').setup {
  --       -- sign_priority = 8,  --set bookmark sign priority to cover other sign
  --       sign_priority=200,
  --       save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
  --       on_attach = function(bufnr)
  --         local bm = require "bookmarks"
  --         local map = vim.keymap.set
  --         map("n", "m", bm.bookmark_toggle) -- add or remove bookmark at current line
  --         map("n", ",i", bm.bookmark_ann) -- add or edit mark annotation at current line
  --         map("n", ",c", bm.bookmark_clean) -- clean all marks in local buffer
  --         map("n", ",n", bm.bookmark_next) -- jump to next mark in local buffer
  --         map("n", ",,", bm.bookmark_next) -- jump to next mark in local buffer
  --         map("n", ";", bm.bookmark_next) -- jump to next mark in local buffer
  --         map("n", ",p", bm.bookmark_prev) -- jump to previous mark in local buffer
  --         -- map("n", ",h", bm.bookmark_list) -- show marked file list in quickfix window
  --       end
  --     }
  --   end
  -- },
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
  -- {
  --   "ThePrimeagen/vim-be-good",
  --   lazy = false,
  --   commands = {
  --     "VimBeGood"
  --   }
  -- },
  -- {
  --   "weizheheng/ror.nvim",
  --   event = "BufEnter *.rb",
  --   config = function()
  --     -- The default settings
  --     require("ror").setup({
  --       test = {
  --         message = {
  --           -- These are the default title for nvim-notify
  --           file = "Running test file...",
  --           line = "Running single test..."
  --         },
  --         coverage = {
  --           -- To customize replace with the hex color you want for the highlight
  --           -- guibg=#354a39
  --           up = "DiffAdd",
  --           -- guibg=#4a3536
  --           down = "DiffDelete",
  --         },
  --         notification = {
  --           -- Using timeout false will replace the progress notification window
  --           -- Otherwise, the progress and the result will be a different notification window
  --           timeout = false
  --         },
  --         pass_icon = "✅",
  --         fail_icon = "❌"
  --       }
  --     })
  --
  --     -- Set a keybind
  --     -- This "list_commands()" will show a list of all the available commands to run
  --     vim.keymap.set("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true })
  --   end
  -- },

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
    "vimwiki/vimwiki",
    event = "BufEnter *.md",
  },
  -- "dstein64/vim-startuptime",
  -- "andythigpen/nvim-coverage",
  {
    import = "plugins"
  }
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = false
  }
})
