require('kanagawa').setup({
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
local colorschemes = { "kanagawa" }

local function set_colorscheme()
  local colorscheme = colorschemes[math.random(1, #colorschemes)]
  vim.o.background = "dark"
  vim.cmd("colorscheme " .. colorscheme)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      set_colorscheme()
    end,
})

