return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- "RRethy/nvim-treesitter-endwise",
    "nvim-treesitter/playground",
    -- 'nvim-treesitter/nvim-treesitter-context',
  },
  lazy = false,
  -- event = "BufReadPre",
  config = function()
    -- Using protected call
    local status_ok, treesitter_config = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
      return
    end

    treesitter_config.setup {
      ensure_installed = { "yaml", "go", "tsx", "lua", "json", "graphql", "regex", "vim", "markdown", "markdown_inline", "dockerfile", "prisma", "vue"},

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
        additional_vim_regex_highlighting = { "markdown" },
      },
      indent = {
        enable = true,
        disable = {
        }
      },
      endwise = {
        enable = true,
      },

      autotag = {
        enable = true
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
      },
      -- markid = { enable = true }
    }
  end,
  -- init = function()
  --   lazy_load("nvim-treesitter")
  -- end,
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
}
