return {
  "ThePrimeagen/harpoon",
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = true,
  keys = {
    "<CR>",
    "m",
    "<BS>",
    "<leader>h",
    "<C-h>",
    "<C-t>",
    "<C-n>",
    "<C-s>",
  },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end

    harpoon.setup({
      tabline = false
    })

    vim.keymap.set('n', '<CR>', function()
      require("harpoon.ui").nav_next()
    end)


    vim.keymap.set('n', '<BS>', function()
      require("harpoon.ui").nav_prev()
    end)

    vim.keymap.set('n', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
    end)

    local ui = require("harpoon.ui")


    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
    function buf_harpoon()
      local original_tabs = require('harpoon').get_mark_config().marks

      for i, tab in ipairs(original_tabs) do
        local is_current = string.match(vim.fn.bufname(), tab.filename) or vim.fn.bufname() == tab.filename
        if is_current then
          return i
        end
      end

      return nil
    end

    -- local mark_color = "#FFA066"
    local function set_mark_color(number, color, fg)
      if not fg then
        fg = "#000000"
      end
      vim.api.nvim_set_hl(0, 'Mark' .. number, { bg = color, fg = fg })
      vim.api.nvim_set_hl(0, 'MarkEnd' .. number, { fg = color })
    end

    -- set_mark_color(1, "#FFA066")
    set_mark_color(1, "#54546D", "#C8C093")
    set_mark_color(2, "#49443C", "#C8C093")
    set_mark_color(3, "#E82424", "#C8C093")
    set_mark_color(4, "#7E9CD8")
    set_mark_color(5, "#76946A")
    -- set_mark_color(4, "#ffffff")
    -- set_mark_color(4, "#A3D4D5")

    -- vim.api.nvim_set_hl(0, "WinBar", { bg = "#FFA066", fg = "#000000" })

    function tabline()
      local is_modified = vim.bo.modified and "●" or ""
      -- local bufname = vim.api.nvim_eval_statusline('%t', {}).str
      local bufname = vim.api.nvim_eval_statusline('%t', {}).str
      if bufname == "NvimTree_1" then
        return ""
        -- return " %#WinBar#  %* NvimTree"
      end
      local extension = vim.fn.expand("%:e")
      local icon, color = require('nvim-web-devicons').get_icon(bufname, extension)
      local icon_str = icon and icon .. " " or ""
      -- section_separators = { left = '', right = '' },
      local current_mark = buf_harpoon(bufname)

      if current_mark == nil then
        return " %#" .. color .. "# " .. icon_str .. "%*" ..
            bufname .. " " .. is_modified .. " %*"
      else
        return "%#WinBar#" ..
            "%#Mark" .. current_mark .. "# " .. current_mark .. " %*" ..
            "%#MarkEnd" .. current_mark .. "#" .. "" .. "%*" ..
            "%#" .. color .. "# " .. icon_str .. "%*" ..
            bufname ..
            " " .. is_modified .. " %*"
      end
    end

    -- vim.opt.showtabline = 2

    -- vim.o.winbar = "%{%v:lua.tabline()%}"
    vim.keymap.set('n', 'm', function()
      local mark = require('harpoon.mark')
      local i = mark.get_current_index()

      mark.toggle_file(i)
      vim.o.winbar = "%{%v:lua.tabline()%}"
    end)

    vim.o.winbar = "%{%v:lua.tabline()%}"

    -- vim.o.winbar='%{%%}'
    -- vim.o.winbar = '%!v:lua.tabline()'
  end
}
