vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local imap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc })
  end

  local xmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('x', keys, func, { buffer = bufnr, desc = desc })
  end
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

  nmap('<leader>rm', '<cmd>lua require("renamer").rename()<cr>', "rename")

  nmap('<leader>a', "<cmd>CodeActionMenu<cr>", 'Code [A]ction')
  imap("<C-a>", "<cmd>CodeActionMenu<cr>", 'Code [A]ction')
  xmap("<C-a>", "<cmd>CodeActionMenu<cr>", 'Code [A]ction')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- nmap('H', "<c-o>", '[G]o [B]ack')
  -- nmap('L', "<c-i>", '[G]o [F]orward')

  -- vim.keymap.set('n', 'gb',  '<c-o>', {

  -- })
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  tsserver = {
  },
  -- sumneko_lua = {
  -- Lua = {
  -- workspace = { checkThirdParty = false },
  -- telemetry = { enable = false },
  -- },
  -- },
}

require('neodev').setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
}
)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
servers.prolog_ls = {}

-- require("typescript").setup({
-- disable_commands = false, -- prevent the plugin from creating Vim commands
-- debug = false, -- enable debug logging for commands
-- preferences = {
-- ImportModuleSpecifier = "relative",
-- },

-- server = { -- pass options to lspconfig's setup method
-- on_attach = on_attach,
-- },
-- })

mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == 'tsserver' then
      require('lspconfig')[server_name].setup {
        copabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative"
          }
        }
      }
      return
    else
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end
  end,
}

local cmp = require 'cmp'

local luasnip = require 'luasnip'

luasnip.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
}
local lspkind = require('lspkind')

local sources = {}
sources['null-ls'] = {
  ignore = true
}
require('fidget').setup({
  sources = sources,
})

cmp.setup {
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      before = function(entry, vim_item)
        return vim_item
      end
    })
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sorting = {
    priority_weight = 2,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs( -4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] =
    cmp.mapping.complete({
      -- reason = cmp.ContextReason.Auto,
    }),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable( -1) then
        luasnip.jump( -1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'spell' },
    { name = 'tags' },
    { name = 'treesitter' },
    -- { name = 'vsnip' },
    { name = 'nvim_lua' },

  },
}
require('lspconfig')['prolog_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.crystalline.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

require'lspconfig'.solargraph.setup{
  capabilities = capabilities,
  on_attach = on_attach,

init_options = {
formatting = true,
},
flags = {
debounce_text_changes = 150,
}
}
require('lspconfig')['yamlls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      trace = {
        server = "verbose"
      },
      schemas = {
        -- kubernetes = "/*.yaml"
        kubernetes = "*.k8s.yaml",
      }
    }
  }
}

require("lsp_signature").setup()

-- require("typescript").setup({

require("renamer").setup({})

local codewindow = require('codewindow')
    codewindow.setup()
    codewindow.apply_default_keybinds()

require('packer').use({
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
})
