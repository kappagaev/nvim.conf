local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('ge', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  vim.keymap.set("n", "S", require("hover").hover, { desc = "hover.nvim" })
  vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

  local keymap = vim.keymap.set

  keymap({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action)

  keymap("n", "<leader>r", vim.lsp.buf.rename)

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
  lua_ls = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {}
mason_lspconfig.setup_handlers {
  function(server_name)
    if server_name == 'tsserver' then
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false,            -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true,        -- fall back to standard LSP definition on failure
        },
        server = {
          -- pass options to lspconfig's setup method
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

local sources = {}
sources['null-ls'] = {
  ignore = true
}
sources['lua_ls'] = {
  ignore = true
}
require('fidget').setup({
  sources = sources,
  window = {
    -- border = 'rounded',
    -- width = 60,
    -- height = 20,
    -- row = 0,
    -- col = 0,
    blend = 0,
  }
})

-- require 'lspconfig'.crystalline.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }

require 'lspconfig'.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,

  root_dir = nvim_lsp.util.root_pattern(".rubocop.yml", ".git"),
  settings = {
  },
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
        kubernetes = "/*.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
        -- kubernetes = "*.k8s.yaml",
      }
    }
  }
}

-- require 'lspconfig'.volar.setup {
--   init_options = {
--     typescript = {
--       tsdk = '/home/kkpagaev/.local/share/nvim/mason/bin/typescript-language-server'
--       -- Alternative location if installed as root:
--       -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
--     },
--     languageFeatures = {
--       implementation = true, -- new in @volar/vue-language-server v0.33
--       references = true,
--       definition = true,
--       typeDefinition = true,
--       callHierarchy = true,
--       hover = true,
--       rename = true,
--       renameFileRefactoring = true,
--       signatureHelp = true,
--       codeAction = true,
--       workspaceSymbol = true,
--       completion = {
--         defaultTagNameCase = 'both',
--         defaultAttrNameCase = 'kebabCase',
--         getDocumentNameCasesRequest = false,
--         getDocumentSelectionRequest = false,
--       },
--     }
--   }
-- }
