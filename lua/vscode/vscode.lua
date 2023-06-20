local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
  {
    'numToStr/Comment.nvim',
    lazy = false,
    opts = {
      toggler = {
        line = 'gcc',
        block = 'gb'
      },
    }
  },
  {
    "kylechui/nvim-surround",
    -- event = "InsertEnter",
    lazy = false,
    opts = {}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
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
          enable = false,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
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
}
require("lazy").setup(plugins, {
})

-- require('kkpagaev.set')
require('kkpagaev.remap')
require('kkpagaev.autocmd')

local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- save
map('n', "<leader>o", "<Cmd>call VSCodeNotifyVisual('workbench.action.files.save', 1)<CR>")
map('n', ",.", "<Cmd>call VSCodeNotifyVisual('workbench.action.files.save', 1)<CR>")

map('n', "<C-h>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex1', 1)<CR>")
map('n', "<C-t>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex2', 1)<CR>")
map('n', "<C-n>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex3', 1)<CR>")
map('n', "<C-s>", "<Cmd>call VSCodeNotifyVisual('workbench.action.openEditorAtIndex4', 1)<CR>")

-- navigation
map('n', "go", "<Cmd>call VSCodeNotifyVisual('workbench.action.navigateBack', 1)<CR>")
map('n', "<leader>t", "<Cmd>call VSCodeNotifyVisual('workbench.action.navigateBack', 1)<CR>")
map('n', "gi", "<Cmd>call VSCodeNotifyVisual('workbench.action.navigateForward', 1)<CR>")

map('n', "<C-o>", "<Cmd>call VSCodeNotifyVisual('workbench.action.navigateBack', 1)<CR>")
map('n', "<C-i>", "<Cmd>call VSCodeNotifyVisual('workbench.action.navigateForward', 1)<CR>")

-- map('n', "S", "<Cmd>call VSCodeNotify('editor.action.showHover')<CR>")

-- coma stuff
map('n', ',', ',')
map('n', ',d', "<Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>")
map('n', ",t", "<Cmd>call VSCodeNotify('extension.goToTest')', 1)<CR>")

-- window
map('n', ";", "<Cmd>call VSCodeNotify('workbench.action.focusNextGroup')', 1)<CR>")
map('n', ",v", "<Cmd>call VSCodeNotify('workbench.action.splitEditor')', 1)<CR>")
map('n', ",s", "<Cmd>call VSCodeNotify('workbench.action.splitEditorDown')', 1)<CR>")


-- telescope
map('n', "<leader><leader>", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')', 1)<CR>")
map('n', "<leader>u", "<Cmd>call VSCodeNotify('workbench.action.quickOpen')', 1)<CR>")

-- zen
map('n', "<leader>z", "<Cmd>call VSCodeNotify('workbench.action.toggleZenMode')', 1)<CR>")

-- debug
map('n', "<A-b>", "<Cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')', 1)<CR>")
map('n', "<leader>c", "<Cmd>call VSCodeNotify('editor.debug.action.toggleBreakpoint')', 1)<CR>")

-- test
map('n', ",h", "<Cmd>call VSCodeNotify('extension.debugJest')', 1)<CR>")

-- explorer
map('n', "<leader>e", "<Cmd>call VSCodeNotifyVisual('workbench.explorer.fileView.focus', 1)<CR>")

local lsp = [[
nnoremap S <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
nnoremap gd <Cmd>call VSCodeNotify('editor.action.goToDeclaration')<CR>
nnoremap ge <Cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
xnoremap gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
]]

map("n", "<C-d>", "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'down')")
map("n", "<C-u>", "<Cmd>call VSCodeExtensionCall('scroll', 'halfPage', 'up')")

vim.api.nvim_command(lsp)
