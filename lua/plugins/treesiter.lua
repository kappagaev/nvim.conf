return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/playground"
  },
  -- event = "BufReadPre",
  config = function()
    -- Using protected call
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_config.setup {
      ensure_installed = { "yaml", "go", "tsx", "lua", "rust", "json", "graphql", "regex", "vim", },

      sync_install = false,
      auto_install = true,
      -- playground = {
      --   enable = true,
      -- },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "v",
          node_decremental = "V",
        }
      },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
        disable = {}
      },
      endwise = {
        enable = true,
      },

      autotag = {
        enable = true
      },
      rainbow = {
        enable = false,
        extended_mode = true,
        max_file_lines = nil
      },
      -- markid = { enable = true }
    }
  end,
}
