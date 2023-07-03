local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  -- client.server_capabilities.semanticTokensProvider = nil

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('ge', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', function()
    require('telescope.builtin').lsp_references()
  end, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  vim.keymap.set("n", "S",
    require("hover").hover
    , { desc = "hover.nvim" })
  -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

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
    -- solargraph = {
    --   diagnostics = true
    -- }
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

-- require("typescript").setup({
--   disable_commands = false, -- prevent the plugin from creating Vim commands
--   debug = false,            -- enable debug logging for commands
--   go_to_source_definition = {
--     fallback = true,        -- fall back to standard LSP definition on failure
--   },
--   server = {
--     -- pass options to lspconfig's setup method
--     copabilities = capabilities,
--     on_attach = on_attach,
--     settings = servers[server_name],
--     init_options = {
--       preferences = {
--         importModuleSpecifierPreference = "relative"
--       }
--     }
--   },
-- })

require("typescript-tools").setup {
  on_attach = on_attach,
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
-- server_capabilities = { semanticTokensProvider = nil},
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {
      -- allowIncompleteCompletions = true,
      -- allowRenameOfImportPath = true,
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
      importModuleSpecifierPreference = "relative"
    },
  },
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

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.eslint_d,
    require("typescript.extensions.null-ls.code-actions"),
    -- null_ls.builtins.diagnostics.erb_lint,
    -- null_ls.builtins.formatting.rubocop,
    -- null_ls.builtins.diagnostics.rubocop,
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

require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
