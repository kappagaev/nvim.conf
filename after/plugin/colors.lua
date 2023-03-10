require('kanagawa').setup({
colors = {
theme = { all = { ui = { bg_gutter = 'none' }  }}
},
dimInactive = false,
transparent = true, -- do not set background color
})

require("catppuccin").setup(
    {
        -- transparent_background = true,
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
local function set_colorscheme()
  local colorscheme = colorschemes[math.random(1, #colorschemes)]
  vim.cmd("colorscheme " .. colorscheme)
end


-- set_colorscheme()
-- vim.cmd("colorscheme spaceduck")
-- vim.cmd("colorscheme PaperColor")

