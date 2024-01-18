local cmp = require("cmp")
local lspkind = require('lspkind')

cmp.setup {
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone",
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',       -- show only symbol annotations
      -- maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      before = function(entry, vim_item)
        vim_item = require('tailwindcss-colorizer-cmp').formatter(entry, vim_item)
        return vim_item
      end
    })
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  sorting = {
    -- priority_weight = 2,
     comparators = {
        cmp.config.compare.recently_used
    },
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ["<C-t>"] = cmp.mapping.close(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] =
        cmp.mapping.complete({
          -- reason = cmp.ContextReason.Auto,
        }),
    -- ['<CR>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = false,
    -- },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      elseif require('luasnip').expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = 'path' },
    { name = 'buffer' },
  },
  -- enabled = function()
  --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --       or require("cmp_dap").is_dap_buffer()
  -- end
}

-- require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
--   sources = {
--     { name = "dap" },
--   },
-- })

-- local cmp_autopairs = require "nvim-autopairs.completion.cmp"
-- require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({
--   filetypes = {
--     ruby = {}
--   }
-- }))

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
