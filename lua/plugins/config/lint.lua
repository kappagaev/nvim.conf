-- require('lint').linters_by_ft = {
--   typescript = {'eslint_d'}
-- }
--
-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.diagnostics.cppcheck,
        -- null_ls.builtins.formatting.clang_format,
        null_ls.builtins.code_actions.eslint_d
    },
})
