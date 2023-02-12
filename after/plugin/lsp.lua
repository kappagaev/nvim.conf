vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  nmap('<leader>rm', '<cmd>lua require("renamer").rename()<cr>', "rename")

  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction')

  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gb', '<c-o>', '[G]o [B]ack')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    phpactor = {},
    solargraph = {
        flags = {
            debounce_text_changes = 150,
        }
    },
    tsserver = {
        importModuleSpecifierPreference = "relative",
    },
    sumneko_lua = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

require('neodev').setup()
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
      require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
      }
    end,
}

local cmp = require 'cmp'

local luasnip = require 'luasnip'

local lspkind = require('lspkind')

require('fidget').setup()

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

    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
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
        { name = 'luasnip',   option = { use_show_condition = false } },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'calc' },
        { name = 'spell' },
        { name = 'tags' },
        { name = 'treesitter' },
        { name = 'vsnip' },
        { name = 'nvim_lua' },

    },
}
require('lspconfig')['prolog_ls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
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

require('nvim-lightbulb').setup({
    ignore = {},
    sign = {
        enabled = true,
        priority = 10,
    },
    float = {
        enabled = false,
        text = "💡",
        win_opts = {},
    },
    virtual_text = {
        enabled = false,
        text = "💡",
        hl_mode = "replace",
    },
    status_text = {
        enabled = false,
        text = "💡",
        text_unavailable = ""
    },
    autocmd = {
        enabled = false,
        pattern = { "*" },
        events = { "CursorHold", "CursorHoldI" }
    }
})
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]

require("lsp_signature").setup()
require("lsp_signature").setup()
