local function lazy_load(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "null-ls" then
              vim.cmd "silent! do FileType"
            end
            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

return {
  "ThePrimeagen/harpoon",
  dependencies = { 'nvim-lua/plenary.nvim',
"nvim-tree/nvim-web-devicons"



  },
  lazy = false,
  -- event = "InsertChange",
  keys = {
    "M",
    "<BS>",
    "<leader>h",
    "<C-h>",
    "<C-t>",
    "<C-n>",
    "<C-s>",
  },
  -- init = function ()
  --   lazy_load("harpoon")
  -- end,
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end

    harpoon.setup({
      tabline = false,
      menu = {
        -- borderchars = {},
        border = {}
      }
    })

    -- vim.keymap.set('n', '<BS>', function()
    --   require("harpoon.ui").nav_prev()
    -- end)

    local winbar = require("markbar.winbar")

    vim.keymap.set('n', '<leader>h', function()
      require("harpoon.ui").toggle_quick_menu()
      winbar.clear()
    end)

    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<C-h>", function()
      if require("harpoon.mark").get_length() == 0 then
        require("telescope.builtin").find_files()

        return
      end
      ui.nav_file(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      ui.nav_file(2)
    end)
    vim.keymap.set("n", "<C-n>", function()
      ui.nav_file(3)
    end)
    vim.keymap.set("n", "<C-s>", function()
      ui.nav_file(4)
    end)

    local group = vim.api.nvim_create_augroup("Harpoon Augroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "harpoon",
      group = group,
      callback = function()
        vim.keymap.set("n", "s", function()
          local curline = vim.api.nvim_get_current_line()
          local working_directory = vim.fn.getcwd() .. "/"
          vim.cmd("vs")
          vim.cmd("e " .. working_directory .. curline)
        end, { buffer = true, noremap = true, silent = true })
      end,
    })

    vim.api.nvim_create_autocmd("BufDelete", {
      pattern = "harpoon",
      group = group,
      callback = function()
        winbar.clear()
      end,
    })

    vim.keymap.set("n", "M", function()
      local mark = require('harpoon.mark')
      local i = mark.get_current_index()

      mark.toggle_file(i)

      winbar.clear()
      winbar.open()
    end)

    winbar.open()
  end
}
