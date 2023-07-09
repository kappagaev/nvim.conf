local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

-- require 'lspconfig'.eslint.setup({
--   capabilities = capabilities,
--   flags = { debounce_text_changes = 500 },
--   on_attach = function(client, bufnr)
--     client.server_capabilities.documentFormattingProvider = true
--     if client.server_capabilities.documentFormattingProvider then
--       local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         pattern = "*",
--         callback = function()
--           vim.lsp.buf.format({ async = true })
--         end,
--         group = au_lsp,
--       })
--     end
--   end,
-- })

-- require 'lspconfig'.eslint.setup({
--   capabilities = capabilities,
--   flags = { debounce_text_changes = 500 },
--   on_attach = function(client, bufnr)
--     client.resolved_capabilities.document_formatting = true
--     if client.resolved_capabilities.document_formatting then
--       local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         pattern = "*",
--         callback = function()
--           vim.lsp.buf.formatting_sync()
--         end,
--         group = au_lsp,
--       })
--     end
--   end,
-- })

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint,
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
