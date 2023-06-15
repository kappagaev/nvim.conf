return {
  "rebelot/kanagawa.nvim",
  dependencies = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    "arturgoms/moonbow.nvim"
  },
  -- install = { colorscheme = { "moonbow" } },
  -- oniViolet
  config = function()
    require('kanagawa').setup({
      colors = {
        palette = {
          -- change all usages of these colors
          oniViolet = "#e46876",
          -- fujiWhite = "#FFFFFF",
        },
        theme = {
          all = {
            ui = {
              bg_p1 = 'none',
              bg_gutter = 'none'
            }
          }
        },
      },
      transparent = true,
      dimInactive = false,
      overrides = function(colors)
        local theme = colors.theme
        return {
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_m1 },
          TelescopePromptBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

          -- Popular plugins that open floats will link to NormalFloat by default;
          -- set their background accordingly if you wish to keep them dark and borderless
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        }
      end,
    })

    vim.cmd("colorscheme kanagawa")
    -- vim.cmd("colorscheme moonbow")

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
    -- vim.opt.laststatus = 0
    vim.o.cmdheight = 0

    local winbar = require("markbar.winbar")

    winbar.open()
  end
  -- commit = "de7fb5f5de25ab45ec6039e33c80aeecc891dd92",
  --
  -- name = "kanagawa",
}
