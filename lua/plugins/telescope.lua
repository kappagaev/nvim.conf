return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
  'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim' },
  lazy = true,
  keys = {
    { "<leader><space>" },
    { "<C-p>" },
    { "<Up>" },
    { "<leader>u" },
    { "<leader>/",      "<cmd>Telescope live_grep<CR>",  desc = "Find a string", silent = true },
    { "<leader>:",      "<cmd>Telescope commands<CR>",  desc = "Find a string", silent = true },
    { "<leader>fh",     "<cmd>Telescope help_tags<CR>",  desc = "Help",          silent = true },
    { "<leader>fg",     "<cmd>Telescope git_status<CR>", desc = "Find Git",      silent = true },
    { ",t",     "<cmd>Telescope resume<CR>", desc = "resume",      silent = true },
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
        file_ignore_patterns = { "%pnpm-lock.yaml", "%package-lock.json", "target/", "node_modules/", ".obsidian/", ".git/", ".cache", "%.out", "%.class",
          "%.ico", "%.pdf","%.mkv","%.ttf","%.woff", "%.eot", "%.svg", '%.webp', '%.png', "%.mp4", "%.zip", "yarn.lock", ".yarn/", ".vscode/" },
        mappings = {
          i = {
            ["<esc>"] = actions.close
          }
        },
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          width = 0.99,
          height = 0.99,
          preview_cutoff = 0,
        },
        prompt_prefix = "   ",
      }
    }
    vim.keymap.set('v', '/', require("telescope.builtin").grep_string, {})
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").find_files, {
      silent = true
    })
    vim.keymap.set("n", "<leader>u", require("telescope.builtin").find_files, {
      silent = true
    })
    vim.keymap.set("n", "<Up>", require("telescope.builtin").find_files, {
      silent = true
    })
    vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, {
      silent = true
    })
  end
}
