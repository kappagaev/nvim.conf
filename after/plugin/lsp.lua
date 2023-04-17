vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)


local on_attach = function(client, bufnr)

  client.server_capabilities.semanticTokensProvider = nil
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

  local keymap = vim.keymap.set

  keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action)

  keymap("n", "<leader>rm", vim.lsp.buf.rename)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  require "lsp_signature".on_attach({
    always_trigger = false,
    transparency = 0.5,
  }, bufnr)

end

local servers = {
  tsserver = {
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}
servers.prolog_ls = {}

mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == 'tsserver' then
require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        copabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        init_options = {
          preferences = {
            importModuleSpecifierPreference = "relative"
          }
        }
    },
})
-- require('lspconfig')[server_name].setup {
-- copabilities = capabilities,
-- on_attach = on_attach,
-- settings = servers[server_name],
-- init_options = {
-- preferences = {
-- importModuleSpecifierPreference = "relative"
-- }
-- }
-- }
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
require("typescript").setup({
    disable_commands = false,
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
    },
    server = { -- pass options to lspconfig's setup method
        on_attach = on_attach,
    },
})
local cmp = require 'cmp'

local lspkind = require('lspkind')

local sources = {}
sources['null-ls'] = {
  ignore = true
}
require('fidget').setup({
  sources = sources,
})

cmp.setup {
  preselect = cmp.PreselectMode.None,
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
    },
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
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'spell' },
    { name = 'treesitter' },
    { name = 'nvim_lua' },

  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
        or require("cmp_dap").is_dap_buffer()
  end
}

require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

require('lspconfig')['prolog_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.crystalline.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require 'lspconfig'.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,

  init_options = {
    formatting = true,
  },
  settings = {
    solargraph = {
      autoformat = true,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true
    }
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
        kubernetes = "/*.yaml"
-- kubernetes = "*.k8s.yaml",
      }
    }
  }
}

