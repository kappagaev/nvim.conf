return {
  'nvim-telescope/telescope.nvim',
  -- event = "BufWinEnter",
  dependencies = { 'nvim-lua/plenary.nvim' },
  lazy = true,
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>u",       "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>/",       "<cmd>Telescope live_grep<CR>",  desc = "Find a string" },
    { "<leader>fh",      "<cmd>Telescope help_tags<CR>",  desc = "Help" },
    { "<leader>fg",      "<cmd>Telescope git_status<CR>", desc = "Find Git" },
  },
  config = function()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
      return
    end

    local actions = require('telescope.actions')
    telescope.setup {
      pickers = {
        colorscheme = {
          enable_preview = true
        },
        find_files = {
          hidden = true
        },

      },
      defaults = {
        path_display = { 'smart' },
        -- file_ignore_patterns = { '.git' },
        file_ignore_patterns = { "node_modules/", ".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
          "%.pdf", "%.mkv", "%.mp4", "%.zip" },
        mappings = {
          i = {
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<esc>"] = actions.close
          }
        }
      },
      layout_config = {
        horizontal = {
          preview_cutoff = 100,
          preview_width = 0.6
        }
      }
    }
  end
}
