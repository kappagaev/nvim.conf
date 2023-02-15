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
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "default", -- Load "default" theme or the experimental "light" theme
})
require("catppuccin").setup(
  {

-- transparent_background = true,
integrations = {
      treesitter = true,
    }
  }
)
local colorschemes = { "kanagawa",  }

local function set_colorscheme()
  local colorscheme = colorschemes[math.random(1, #colorschemes)]
  vim.cmd("colorscheme " .. colorscheme)
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      set_colorscheme()
    end,
})

