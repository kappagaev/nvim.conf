-- colors = {
require('kanagawa').setup({
    theme = { all = { ui = { bg_gutter = 'none' }  }},
    dimInactive = false,
    transparent = true, -- do not set background color
-- theme = "wave",              -- Load "wave" theme when 'background' option is not set
-- background = {               -- map the value of 'background' option to a theme
-- dark = "dragon",           -- try "dragon" !
-- },
})

require("catppuccin").setup(
{
integrations = {
treesitter = true,
}
}
)
vim.cmd("colorscheme kanagawa")
-- vim.o.background = "light"
-- vim.cmd("colorscheme onenord")
-- local colorschemes = { "kanagawa", "spaceduck", "PaperColor", "catppuccin-mocha"}
-- local colorschemes = { "catppuccin-macchiato", "tokyonight-storm", "tokyonight-moon", "kanagawa" }
-- local function set_colorscheme()
-- local colorscheme = colorschemes[math.random(1, #colorschemes)]
-- vim.cmd("colorscheme " .. colorscheme)
-- end


-- set_colorscheme()
-- vim.cmd("colorscheme spaceduck")
-- vim.cmd("colorscheme PaperColor")

