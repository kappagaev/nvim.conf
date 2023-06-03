return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>" }
  },
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set('n', 'c', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'n', api.node.open.preview, opts('Open Preview'))
    end,
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    sync_root_with_cwd = true,
    update_cwd = false,
    sort_by = "case_sensitive",
    view = {
      adaptive_size = true,
      mappings = {
        list = {
          { key = "c", action = "close_node" },
          { key = "n", action = "preview" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
    update_focused_file = {
      enable = false,
      update_cwd = false
    },
    diagnostics = {
      enable = true,
      show_on_dirs = false,
      debounce_delay = 50,
      icons = {
        hint = 'H',
        info = 'I',
        warning = 'W',
        error = 'E'
      }
    }
  },
}
