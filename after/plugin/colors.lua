require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    functionStyle = {},
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "default" -- Load "default" theme or the experimental "light" theme
})
-- vim.cmd("colorscheme middlenight_blue")
-- vim.cmd("colorscheme dracula_blood")
vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme slate")
-- vim.cmd("colorscheme f")
-- vim.cmd("colorscheme ukraine")
-- setup must be called before loading
