-- colors = {
require('kanagawa').setup({
  theme = { all = { ui = { bg_gutter = 'none' } } },
  transparent = true,
  dimInactive = false,
})

vim.cmd("colorscheme kanagawa")
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
