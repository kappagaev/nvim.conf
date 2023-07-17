local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require 'lspconfig'.eslint.setup({
  capabilities = capabilities,
  flags = { debounce_text_changes = 500 },
})

local util = require "formatter.util"

-- :clown:
local function format_eslint()
  return {
    exe = "eslint_d",
    args = {
      "--stdin",
      "--stdin-filename",
      util.escape_path(util.get_current_buffer_file_path()),
      "--fix-to-stdout",
    },
    stdin = true,
    try_node_modules = true,
  }
end

local function format_prettier()
  return {
    exe = "prettierd",
    args = { util.escape_path(util.get_current_buffer_file_path()) },
    stdin = true,
  }
end

require('formatter').setup {
  logging = true,
  filetype = {

    -- typescript = { format_prettier },
    -- typescriptreact = { format_prettier },
    -- vue = { format_prettier },

    typescript = { format_eslint },
    typescriptreact = { format_eslint },
    vue = { format_eslint },
    astro = { format_eslint },
  }
}

local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au("BufWritePost", {
  group = ag("formatting", {}),
  pattern = "*",
  callback = function()
    vim.cmd("FormatWrite")
  end
})
