-- local custom_kanagawa = require 'lualine.themes.kanagawa'
-- custom_kanagawa.normal.c.bg = '#14141414141'
-- custom_kanagawa.normal.a = { bg = '#f05033', gui = 'bold', fg = '#000000' }
-- custom_kanagawa.normal.b = { bg = custom_kanagawa.normal.b.bg, gui = 'bold', fg = '#C8C093' }

local function count_items(qf_list)
  if #qf_list > 0 then
    local valid = 0
    for _, item in ipairs(qf_list) do
      if item.valid == 1 then
        valid = valid + 1
      end
    end
    if valid > 0 then
      return tostring(valid)
    end
  end
  return
end

require('lualine').setup({
  options = {
    globalstatus = true,
    refesh = {
      statusline = 100000000000000,
    },
    theme = "kanagawa",
    -- theme = 'spaceduck',
    icons_enabled = true,
    component_separators = { left = '', right = '|' },
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = ' ', right = ' '},
    -- section_separators = { left = '', right = ''},

    section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- theme = 'gruvbox_material',
    disabled_filetypes = {
      'fugitive'
      -- 'NvimTree',
      -- 'neo-tree',
      -- winbar = {
      --   'harpoon',
      --   'dap-repl',
      --   'Trouble',
      --   'fugitive'
      -- }
      -- 'TelescopePrompt',

      -- 'dapui_scopes',
      -- 'dapui_stacks',
      -- 'dapui_watches',
      -- 'dapui_breakpoints',

    },
  },
  sections = {
    lualine_a = {
      -- function()
      -- uoeu
      --   return "|"
      -- end
    },
    lualine_b = {
      {
        function()
          return '▊'
        end,
        -- color = { fg = colors.blue },
        padding = { right = 1 },
      },
      {
        'mode',
        padding = { left = 0, right = 1}
      },
      'path',
      {
        function()
          local loc_values = vim.fn.getloclist(vim.api.nvim_get_current_win())
          local items = count_items(loc_values)
          if items then
            return 'Loc: ' .. items
          end
          return ""
        end,
        on_click = function(clicks, button, modifiers)
          local winid = vim.fn.getqflist(vim.api.nvim_get_current_win(), { winid = 0 }).winid
          if winid == 0 then
            vim.cmd.lopen()
          else
            vim.cmd.lclose()
          end
        end,
      },
      {
        function()
          local qf_values = vim.fn.getqflist()
          local items = count_items(qf_values)
          if items then
            return 'Qf: ' .. items
          end
          return ""
        end,
        on_click = function(clicks, button, modifiers)
          local winid = vim.fn.getqflist({ winid = 0 }).winid
          if winid == 0 then
            vim.cmd.copen()
          else
            vim.cmd.cclose()
          end
        end,
      },
    },
    lualine_c = { 'diff', 'diagnostics' },

    lualine_x = {
      'filetype',
      'encoding',
    },
    -- lualine_y = { nvimbattery },
    lualine_y = {
      {
        function()
          local words = vim.fn.wordcount()['words']
          return 'Words: ' .. words
        end,
        cond = function()
          local ft = vim.opt_local.filetype:get()
          local count = {
            latex = true,
            tex = true,
            text = true,
            markdown = true,
            vimwiki = true,
          }
          return count[ft] ~= nil
        end,
      },
    },
    lualine_z = {
      "selectioncount",
      "searchcount"
    }
  },

  inactive_sections = {

  },
  tabline = {},
  extensions = { 'fugitive' }
})
