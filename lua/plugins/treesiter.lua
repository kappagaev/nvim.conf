return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPre",
  config = function()
    -- Using protected call
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_config.setup {
      ensure_installed = { "yaml", "go", "tsx", "lua", "rust", "json", "graphql", "regex", "vim", "ruby" },

      sync_install = false,
      auto_install = true,
      playground = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<c-BS>",
        },
      },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = {}
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
