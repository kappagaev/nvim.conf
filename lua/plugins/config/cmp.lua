local cmp = require("cmp")
-- local lspkind = require('lspkind')

cmp.setup {
  preselect = cmp.PreselectMode.None,
  -- completion = {
  --   completeopt = "menu,menuone",
  -- },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
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
        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
      elseif require('luasnip').expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip" },
    { name = 'path' },
    { name = 'buffer' },
  },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({
  filetypes = {
    ruby = {}
  }
}))

