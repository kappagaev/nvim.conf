return {
  'nvim-telescope/telescope.nvim',
  event = "BufWinEnter",
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>u",       "<cmd>Telescope find_files<CR>", desc = "Find Files" },
    { "<leader>/",       "<cmd>Telescope live_grep<CR>",  desc = "Find a string" },
    { "<leader>fh",      "<cmd>Telescope help_tags<CR>",  desc = "Help" },
    { "<leader>fg",      "<cmd>Telescope git_status<CR>", desc = "Find Git" },
  },
  opts = {
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
    },
    layout_config = {
      horizontal = {
        preview_cutoff = 100,
        preview_width = 0.6
      }
    }
  }
}
