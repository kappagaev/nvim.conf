local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    bright_bg = utils.get_highlight("Folded").bg,
    bright_fg = utils.get_highlight("Folded").fg,
    red = utils.get_highlight("DiagnosticError").fg,
    dark_red = utils.get_highlight("DiffDelete").bg,
    green = utils.get_highlight("String").fg,
    blue = utils.get_highlight("Function").fg,
    gray = utils.get_highlight("NonText").fg,
    orange = utils.get_highlight("Constant").fg,
    purple = utils.get_highlight("Statement").fg,
    cyan = utils.get_highlight("Special").fg,
    diag_warn = utils.get_highlight("DiagnosticWarn").fg,
    diag_error = utils.get_highlight("DiagnosticError").fg,
    diag_hint = utils.get_highlight("DiagnosticHint").fg,
    diag_info = utils.get_highlight("DiagnosticInfo").fg,
    git_del = utils.get_highlight("diffDeleted").fg,
    git_add = utils.get_highlight("diffAdded").fg,
    git_change = utils.get_highlight("diffChanged").fg,
}

local DAPMessages = {
    condition = function()
        local session = require("dap").session()
        return session ~= nil
    end,
    provider = function()
        return " " .. require("dap").status()
    end,
    hl = "purple"
    -- see Click-it! section for clickable actions
}

local SearchCount = {
    condition = function()
        return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0
    end,
    init = function(self)
        local ok, search = pcall(vim.fn.searchcount)
        if ok and search.total then
            self.search = search
        end
    end,
    provider = function(self)
    end,
    hl = {
    fg = "git_del"
  }
}

local CloseButton = {
    condition = function(self)
        return not vim.bo.modified
    end,
    -- a small performance improvement:
    -- re register the component callback only on layout/buffer changes.
    update = {'WinNew', 'WinClosed', 'BufEnter'},
    { provider = " " },
    {
        provider = "",
        -- provider = "",
        hl = { fg = "gray" },
        on_click = {
            minwid = function()
                return vim.api.nvim_get_current_win()
            end,
            callback = function(_, minwid)
                vim.api.nvim_win_close(minwid, true)
            end,
            name = "heirline_winbar_close_button"
        },
    },
}


require("heirline").setup({
  statusline = {
    -- ViMode,
    DAPMessages,
    SearchCount
},
  -- winbar = {
  --   SearchCount,
  --   {
  --     provider = "%="
  --   },
  --   CloseButton,
  -- },
  opts = {
    colors = colors
  },
    -- winbar = WinBar,
    -- tabline = TabLine,
    -- statuscolumn = StatusColumn
})
